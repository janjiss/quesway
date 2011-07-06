class Tracker < ActiveRecord::Base
  attr_accessible :survey_id, :respondent_id, :progress, :completed
  belongs_to :survey
end
