# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?

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
