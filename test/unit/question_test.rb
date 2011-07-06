require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Question.new.valid?
  end
end
