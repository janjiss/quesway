# encoding: utf-8
class SurveysController < ApplicationController
  before_filter :authorize, :except => [:index]
  def index
    if admin?
      @surveys = Survey.page(params[:page]).per(10)
    else
      @surveys = Survey.page(params[:page]).per(10).where(:published => true)
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      redirect_to @survey, :notice => "Aptauja veiksmīgi pievienota"
    else
      render :action => 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      redirect_to @survey, :notice  => "Aptauja veiksmīgi labota"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    redirect_to surveys_url, :notice => "Aptauja veiksmīgi dzēsta"
  end
end
