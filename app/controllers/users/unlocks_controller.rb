# frozen_string_literal: true

class Users::UnlocksController < Devise::UnlocksController
  # GET /resource/unlock/new
  def new
    super
  end

  # POST /resource/unlock
  def create
    super
  end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    super
  end

  protected

  # パスワードのロック解除指示で送信した後に使用するpath
  def after_sending_unlock_instructions_path_for(resource)
    super(resource)
  end

  # リソースのロックを解除した後に使用するpath
  def after_unlock_path_for(resource)
    super(resource)
  end
end
