class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def confirm
    @room = Room.find(reservation_params[:room_id])
    @reservation = current_user.reservations.new(reservation_params)
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)

    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました"
    else
      render :confirm
    end
  end
  
  def index
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end

  def edit
    @reservation = current_user.reservations.find(params[:id])
  end

  def update
    @reservation = current_user.reservations.find(params[:id])

    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: "予約を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy

    redirect_to :reservations, notice: "予約を削除しました"
  end

  private

  def reservation_params
    params.require(:reservation).permit(:room_id, :checkin_at, :checkout_at, :guest_count)
  end
end
