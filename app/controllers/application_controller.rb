# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_respondent
  helper_method :current_respondent
  helper_method :admin?

  private

  def current_respondent
    if !session[:respondent_id]
      respondent = Respondent.create
      session[:respondent_id] = respondent.id
      return respondent
    else
      return Respondent.find(session[:respondent_id])
    end
  end

  protected

  def admin?
    session[:password] == ADMIN_PASSWORD
  end

  def authorize
    unless admin?
      flash[:error] = "You do not have access to this area"
      redirect_to root_url
      false
    end
  end

end
