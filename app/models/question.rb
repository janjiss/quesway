# encoding: utf-8
class Question < ActiveRecord::Base
  attr_accessible :survey_id, :body, :choices, :category, :sequence
  belongs_to :survey
  has_many :answers, :dependent => :destroy

  validates_presence_of :body, :category, :survey_id, :sequence,:message => "Lūdzu aizpildiet visus laukus"
  validates_length_of :body, :within => (1..50),:message => "Jautājumam ir jābūt vismaz vienu vai līdz 50 simboliem garam."
  validates_presence_of :choices, :if => :needs_collection_answers?,:message => "Lūdzu ievadiet atbilžu variantus"
  validates_length_of :choices, :minimum => 2,:message => "Lūdzu ievadiet vismaz divus atbilžu variantus"
  private
  def needs_collection_answers?
    if category == "collection"
      return true
    end
  end
end
