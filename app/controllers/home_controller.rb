class HomeController < ApplicationController
  def index
    if params[:keyword].present?
      @rooms = Room.where("address LIKE ?", "%#{params[:keyword]}%")
    else 
      @rooms = Room.all
    end
  end
end