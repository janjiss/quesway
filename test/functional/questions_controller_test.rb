require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Question.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Question.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Question.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to question_url(assigns(:question))
  end

  def test_edit
    get :edit, :id => Question.first
    assert_template 'edit'
  end

  def test_update_invalid
    Question.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Question.first
    assert_template 'edit'
  end

  def test_update_valid
    Question.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Question.first
    assert_redirected_to question_url(assigns(:question))
  end

  def test_destroy
    question = Question.first
    delete :destroy, :id => question
    assert_redirected_to questions_url
    assert !Question.exists?(question.id)
  end
end
