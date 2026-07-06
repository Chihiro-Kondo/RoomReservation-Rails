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
  end

  def show #登録された施設
  end

  def edit #登録した施設の編集
  end

  def update #内容の更新
  end

  def destroy #施設の削除
  end
end
