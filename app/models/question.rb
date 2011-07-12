# encoding: utf-8
class Question < ActiveRecord::Base
  attr_accessible :survey_id, :body, :choices, :category, :sequence

  belongs_to :survey
  has_many :answers, :dependent => :destroy

  validates_presence_of :body, :category, :survey_id, :sequence
  validates_length_of :body, :within => (1..50)
  validates_presence_of :choices, :if => :choices_answer?
  validates_length_of :choices, :minimum => 2, :if => :choices_answer?

  before_save :remove_choices?
  before_save :escape_choices

  # Return choice answers array
  def choice_answers
    if choices_answer?
      answer_array = []
      choices_array = choices.split("|")
      percent_coefficient = 100.to_f/answers.count

      #For each choice push answers to choices array
      for choice in choices_array
        answer_count = Answer.where(:answer => choice, :question_id => id).count
        percent = percent_coefficient*answer_count
        answer_array.push({
          :answer_count => answer_count.to_s,
          :choice=> choice,
          :percent => percent.to_i.to_s
      })
      end 
      return answer_array
    else
      return false
    end
  end

  def string_or_number_answers
    answers.find(:all, :limit => 5, :order => 'created_at DESC')
  end

  def choices_answer? 
    category == "choices"
  end

  def string_answer?
    category == "string"
  end

  def number_answer? 
    category == "number"
  end
  private
  # If question category is not choices, then remove choices
  def remove_choices?
    self.choices = nil unless self.choices_answer?
  end

  #Escape choices from unwanted chars
  def escape_choices
    if choices != nil
      #Remove whitespace and tabs from beginning
      choices.gsub!(/^[ \t]+/,"")
      #Remove whitespace and tabs from ending
      choices.gsub!(/[ \t]+$/,"")
      #remove whitespaces near pipes
      choices.gsub!(/[ | ][ |][| ]/, "|")
      #Create array from cleared choices
      #Remove choices, if they are more than 25 chars or less than 1 char long and if they are a whitespace
      choice_array = choices.split("|").delete_if {|x| x.length > 25 || x.length < 1 || x == " " }
      return choice_array.join("|")
    end
  end
end
