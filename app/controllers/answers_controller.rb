# encoding: utf-8
class AnswersController < ApplicationController
  before_filter :survey_completed?, :only => [:new, :create]
  before_filter :initialize_tracker, :only => [:new, :create]
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
      survey_id = params[:survey_id]
      #Find matching tracker (It is initialized with before filter)
      tracker = Tracker.where(:survey_id => survey_id, :respondent_id => current_respondent.id).last
      @survey = Survey.find(survey_id)
      @question = Question.where(:survey_id => survey_id, :sequence => tracker.progress).last
      @answer = Answer.new
    else
      redirect_to root_url, :notice => "Please select survey"
    end
  end

  def create
    survey_id = params[:survey_id]
    @answer = Answer.new(params[:answer])
    #Find current tracker 
    tracker = Tracker.where(
      :survey_id => survey_id, 
      :respondent_id => current_respondent.id
    ).last
    if @answer.save
      tracker.save
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
    if Tracker.where(:survey_id => params[:survey_id], :respondent_id => current_respondent.id).count < 1
      tracker = Tracker.create(
        :survey_id => params[:survey_id],
        :respondent_id => current_respondent.id
      )
    end
  end
  def survey_completed?
    if Tracker.where(:survey_id => params[:survey_id], :respondent_id => current_respondent.id, :completed => true).count > 0
      redirect_to root_url, :notice => "Survey has ben completed, thanks!"
    end
  end
  def question_counter
    tracker = Tracker.where(
      :survey_id => params[:survey_id],
      :respondent_id => current_respondent.id
    ).last
    return {
      :progress => tracker.progress-1, 
      :total => tracker.survey.questions.count, 
      :remaining => tracker.survey.questions.count-tracker.progress 
    }
  end
end
