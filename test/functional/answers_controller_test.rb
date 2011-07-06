require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Answer.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Answer.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Answer.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to answer_url(assigns(:answer))
  end

  def test_edit
    get :edit, :id => Answer.first
    assert_template 'edit'
  end

  def test_update_invalid
    Answer.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Answer.first
    assert_template 'edit'
  end

  def test_update_valid
    Answer.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Answer.first
    assert_redirected_to answer_url(assigns(:answer))
  end

  def test_destroy
    answer = Answer.first
    delete :destroy, :id => answer
    assert_redirected_to answers_url
    assert !Answer.exists?(answer.id)
  end
end
