class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index #検索結果一覧
    @rooms = Room.all
    
    #エリア検索
    if params[:address].present?
      address = params[:address].strip

      prefecture_map = {
        "東京" => "東京都",
        "大阪" => "大阪府",
        "京都" => "京都府",
        "札幌" => "札幌市"
      }
      search_word = prefecture_map[address] || address

      @rooms = @rooms.where("address LIKE ?", "%#{search_word}%")
    end

    #フリーワード検索
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"

      @rooms = @rooms.where("name LIKE :keyword OR address LIKE :keyword OR description LIKE :keyword",
        keyword: keyword
      )
    end
  end

  def new #施設の作成
    @room = current_user.rooms.new
  end

  def create #施設の保存
    @room = current_user.rooms.new(params.require(:room).permit(:name, :description,
    :price, :address, :image))
    
    if @room.save
      redirect_to :rooms, notice: "施設を新規作成しました"
    else
      render "new", status: :unprocessable_entity
    end
  end
 
  def own #登録された施設
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  def show #各施設の詳細
    @room = Room.find(params[:id])
    @reservation = Reservation.new(room: @room)
  end

  def edit #登録した施設の編集
    @room = Room.find(params[:id])
  end

  def update #内容の更新
    @room = current_user.rooms.find(params[:id])

    if @room.update(room_params)
      redirect_to rooms_path, notice: "施設内容を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy #施設の削除
    @room = current_user.rooms.find(params[:id])
    @room.destroy

    redirect_to own_rooms_path, notice: "施設を削除しました"
  end
  private

  def room_params
    params.require(:room).permit(:name,:description, :price, :address, :image)
  end
end

