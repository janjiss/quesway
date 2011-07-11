# encoding: utf-8
class SessionsController < ApplicationController
  def create
    if params[:password] != ADMIN_PASSWORD
      flash[:notice] = "Nepareiza parole"
      redirect_to login_path
    else
      session[:password] = params[:password]
      flash[:notice] = "Jūs esat sekmīgi ielogojušies"
      redirect_to root_url
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Jūs esat sekmīgi izlogojušies"
    redirect_to root_url
  end
end
