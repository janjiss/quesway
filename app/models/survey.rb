# encoding: utf-8
class Survey < ActiveRecord::Base
  attr_accessible :name, :published
  has_many :answers, :through => :questions
  has_many :trackers
  has_many :questions, :dependent => :destroy
  has_many :trackers, :dependent => :destroy

  validates_presence_of :name, :message => "Nosaukums ir obligāts"
  validates_length_of :name, :within => (5..50), :message => "Nosaukumam ir jābūt no 5 līdz 50 simboliem garam"

  def validate
    if published == true && questions.count < 1 
      errors.add_to_base "Lūdzu pievienojiet vismaz vienu jautājumu, lai publicētu savu aptauju"
    end
  end
  
end
