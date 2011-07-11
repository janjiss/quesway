# encoding: utf-8
class Survey < ActiveRecord::Base
  attr_accessible :name, :published
  has_many :trackers, :dependent => :destroy
  has_many :answers, :through => :questions
  has_many :questions, :dependent => :destroy


  validates_presence_of :name
  validates_length_of :name, :within => (5..50)

  def validate
    if published == true && questions.count < 1 
      errors.add_to_base "Please add at least one question to survey before publishing"
    end
  end
  
end
