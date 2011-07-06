# encoding: utf-8
class Answer < ActiveRecord::Base
  attr_accessible :question_id, :answer
  belongs_to :question
  belongs_to :survey
  has_many :trackers

  validates_presence_of :answer, :message => "Lūdzu aizpildiet atbildes lauku."
  validates_numericality_of :answer, :if => :num_answer, :message => "Lūdzu ievadiet ciparu."
  validates_length_of :answer,:minimum => 2, :if => :choices_answer,:message => "Lūdzu ievadiet vismaz divus atbilžu variantus"


  private
  def num_answer
    if question.category == "number"
      return true
    else
      return false
    end
  end
  def str_answer
    if question.category == "string"
      return true
    else
      return false
    end
  end
  def choices_answer
    if question.category == "collection"
      return true
    else
      return false
    end
  end
end
