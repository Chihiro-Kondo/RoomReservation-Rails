class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(profile_params)
      redirect_to "/users/profile", notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #以下、ストロングパラメータ
  private
  
  def profile_params
    params.requiire(:user).permit(
      :avatar,
      :name,
      :introduction
    )
  end
end
