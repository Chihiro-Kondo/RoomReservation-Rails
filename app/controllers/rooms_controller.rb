class RoomsController < ApplicationController
  def index #検索結果一覧
    @rooms = Room.all
    
    #エリア検索
    if params[:address].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:address]}%")
    end

    #フリーワード検索
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"

      @rooms = @rooms.where("name LIKE :keyword OR description LIKE :keyword",
        keyword: keyword
      )
    end
  end

  def new #施設の作成
    @room = Room.new
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
 
  def own 
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  def show #登録された施設
    @room = Room.find(params[:id])
  end

  def edit #登録した施設の編集
  end

  def update #内容の更新
  end

  def destroy #施設の削除
  end
end
