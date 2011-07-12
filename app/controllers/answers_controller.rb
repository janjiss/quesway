# encoding: utf-8
class AnswersController < ApplicationController
  before_filter :initialize_tracker, :only => [:new, :create]
  before_filter :survey_completed?, :only => [:new, :create]
  before_filter :authorize, :only => [:index]
  helper_method :question_counter

  def index
    @question = Question.find(params[:question_id])
    @answers = Answer.page(params[:page]).where(:question_id => @question.id)
    #If questions have predefined answers, then count percentage
    if @question.choices_answer?
      @answer_array = []
      choices_array = @question.choices.split("|")
      percent_coefficient = 100.to_f/@answers.count
      #For each choice push answer count to @answer_array
      for choice in choices_array
        answer_count = Answer.where(:answer => choice, :question_id => @question.id).count
        percent = percent_coefficient*answer_count
        @answer_array.push({
          :answer_count => answer_count.to_s,
          :choice=> choice,
          :percent => percent.to_i.to_s
        })
      end    
    end
  end

  def new
    if params[:survey_id]
      survey_id = params[:survey_id].to_i
      @survey = Survey.find(survey_id)
      @question = Question.where(:survey_id => survey_id, :sequence => session[survey_id][:progress]).last
      @answer = Answer.new
    else
      redirect_to root_url, :notice => "Please select survey"
    end
  end

  def create
    survey_id = params[:survey_id].to_i
    @answer = Answer.new(params[:answer])
    if @answer.save
      #Add one step to progress
      session[survey_id][:progress] += 1
      redirect_to new_answer_path(:survey_id  => survey_id)
    else
      #If save fails, then initialize @question variable, so it is accessible
      @question = Question.where(
        :survey_id => survey_id, 
        :sequence => tracker.progress
      ).last
      render :action => 'new', :survey_id => survey_id
    end
  end

  private
  def initialize_tracker
    survey_id = params[:survey_id].to_i
    if !session[survey_id]
      session[survey_id] = {:progress => 1}
    end
  end
  def survey_completed?
    survey_id = params[:survey_id].to_i
    question_count = Survey.find(survey_id).questions.count
    # If progress is bigger than question count, then survey is completed
    if session[survey_id][:progress] > question_count
      redirect_to root_url, :notice => "Survey has been completed, thanks!" 
    end
  end
  def question_counter
  survey_id = params[:survey_id].to_i
  total = Survey.find(survey_id).questions.count.to_i
  progress = session[survey_id][:progress]
    return {
      :progress => progress-1,
      :total => total,
      :remaining => total-progress 
    }
  end
end
