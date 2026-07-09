class ReservationsController < ApplicationController
  before_action :authenticate_user!


  def confirm
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)

    if @reservation.save
      redirect_to @reservation, notice: "予約が完了しました"
    else
      render :corfirm
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:room_id, :check_in, :check_out, :guest_count)
  end
end
