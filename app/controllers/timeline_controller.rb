class TimelineController < ApplicationController
  def index
    @films = Film.all.order(created_at: :desc).page(params[:page]).per(10).search(params[:search])
  end
end
