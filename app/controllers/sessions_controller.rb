# encoding: utf-8
class SessionsController < ApplicationController
  def create
    session[:password] = params[:password]
    flash[:notice] = "Jūs esat sekmīgi ielogojušies"
    redirect_to root_url
  end

  def destroy
    reset_session
    flash[:notice] = "Jūs esat sekmīgi izlogojušies"
    redirect_to root_url
  end
end
