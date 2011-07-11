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
      redirect_to surveys_url, :notice => "Please choose survey from list"
    end
  end

  def create
    # If answer type is not collection, then do not enter possible answer values.
    @question = Question.new(params[:question])

    #initialize survey variable, so it is present, when redirected to survey
    @survey = Survey.find(params[:question][:survey_id])
    #Adds questions sequence based on question count
    @question.sequence = @survey.questions.count+1
    if @question.save
      redirect_to survey_path(@survey), :notice => "Question successfuly created"
    else
      render :action => 'new'
    end
  end

  def edit
    if params[:survey_id]
      @survey = Survey.find(params[:survey_id])
      @question = Question.find(params[:id])
    else
      redirect_to surveys_url, :notice => "Please choose survey from list"
    end
  end

  def update
    # If answer type is not collection, then do not enter possible answer values.
    @question = Question.find(params[:id])
    
    #initialize survey variable, so it is accessible in case of redircet
    @survey = Survey.find(params[:question][:survey_id])

    if @question.update_attributes(params[:question])
      redirect_to survey_path(@survey), :notice => "Question sucsessfuly updated"
    else
      render :action => 'edit'
    end
  end

  private

  def survey_published?
    survey_id ||= params[:survey_id]
    survey_id ||= params[:question][:survey_id]
    @survey = Survey.find(survey_id)
    # Redirect to survey if it is published
    redirect_to survey_path(@survey), :notice => "Sorry, but survey is publsihed" if @survey.published == true
  end
end
