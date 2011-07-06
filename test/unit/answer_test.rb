require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Answer.new.valid?
  end
end
