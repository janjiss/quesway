# encoding: utf-8
class QuestionsController < ApplicationController
  before_filter :authorize
  before_filter :survey_published?, :only => [:new, :create, :edit, :update, :destroy]
  def index
    @survey = Survey.find(params[:survey_id])
    @questions = Question.where(:survey_id => @survey.id).page(params[:page])
  end

  def new
    if params[:survey_id]
      @survey = Survey.find(params[:survey_id])
      @question = Question.new
    else
      redirect_to surveys_url, :notice => "Lūdzu izvēlaties aptauju no saraksta"
    end
  end

  def create
    # If answer type is not collection, then do not enter possible answer values.
    @question = Question.new(params[:question])

    #Remove choices if question category is not equal to collection
    @question.choices = nil if @question.category != "collection"

    #initialize survey variable, so it is present, when redirected to survey
    @survey = Survey.find(params[:question][:survey_id])
    #Adds questions number
    @question.sequence = @survey.questions.count+1
    if @question.save
      redirect_to survey_path(@survey), :notice => "Jautājums tika sekmīgi pievienots"
    else
      render :action => 'new'
    end
  end

  def edit
    if params[:survey_id]
      @survey = Survey.find(params[:survey_id])
      @question = Question.find(params[:id])
    else
      redirect_to surveys_url, :notice => "Lūdzu izvēlaties aptauju no saraksta"
    end
  end

  def update
    # If answer type is not collection, then do not enter possible answer values.
    @question = Question.find(params[:id])

    #Remove choices if question category is not equal to collection

    params[:question][:choices] = nil unless params[:question][:category] == "collection"
    
    #initialize survey variable, so it is accessible in case of redircet
    @survey = Survey.find(params[:question][:survey_id])

    if @question.update_attributes(
        :category => params[:question][:category],
        :body => params[:question][:body],
        :choices => escape_choices(params[:question][:choices])
      )
      redirect_to survey_path(@survey), :notice => "Jautājums sekmīgi labots"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_url, :notice => "Jautājums sekmīgi dzēsts"
  end
  private
  #clears choices from spaces and removes them if length is not valid (1..25)
  def escape_choices(choices)
    if choices != nil
      #Remove whitespace and tabs from beginning
      choices.gsub!(/^[ \t]+/,"")
      #Remove whitespace and tabs from ending
      choices.gsub!(/[ \t]+$/,"")
      #remove whitespaces near pipes
      choices.gsub!(/[ | ][ |][| ]/, "|")
      #Create array from cleared choices
      #Remove choices, if they are more than 25 chars or less than 1 char long and if they are a whitespace
      choice_array = choices.split("|").delete_if {|x| x.length > 25 || x.length < 1 || x == " " }
      return choice_array.join("|")
    end
  end
  def survey_published?
    if params[:survey_id]
      survey_id = params[:survey_id]
    elsif params[:question][:survey_id]
      survey_id = params[:question][:survey_id]
    end
    @survey = Survey.find(survey_id)
    if @survey.published == true
      redirect_to survey_path(@survey), :notice => "Atvainojamies, bet aptauja jau ir publicēta"
    end
  end
end
