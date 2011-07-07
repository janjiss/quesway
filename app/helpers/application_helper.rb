module ApplicationHelper
  def answer_type_array 
    [["Number", "number"],["Text", "string"],["Multiple answers", "collection"]]
  end

  def choice_array_from_string(question)
    options_for_select(question.choices.split("|"))
  end
end
