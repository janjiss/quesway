# encoding: utf-8
class Answer < ActiveRecord::Base
  attr_accessible :question_id, :answer
  belongs_to :question
  belongs_to :survey
  has_many :trackers

  validates_presence_of :answer
  validates_numericality_of :answer, :if => :number_answer?
  validates_length_of :answer,:minimum => 2, :if => :choices_answer?


  private
  def choices_answer? 
    question.choices_answer?
  end
  def string_answer? 
    question.string_answer?
  end
  def number_answer? 
    question.number_answer?
  end
end
