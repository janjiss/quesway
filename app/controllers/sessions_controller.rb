# encoding: utf-8
class SessionsController < ApplicationController
  def create
    if params[:password] != ADMIN_PASSWORD
      flash[:notice] = "incorrect password"
      redirect_to login_path
    else
      session[:password] = params[:password]
      flash[:notice] = "You have successfully logged in"
      redirect_to root_url
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have successfully logged out"
    redirect_to root_url
  end
end
