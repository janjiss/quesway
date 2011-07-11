class Tracker < ActiveRecord::Base
  attr_accessible :survey_id, :respondent_id, :progress, :completed
  belongs_to :survey
  before_save :set_completed?
  before_save :add_progress


  #set tracker.completed to true if all questions are answered
  def set_completed?
    if progress >= survey.questions.count
      self.completed = true
    end
  end
  #Add +1 to progress if saved
  def add_progress
    self.progress += 1
  end

end
