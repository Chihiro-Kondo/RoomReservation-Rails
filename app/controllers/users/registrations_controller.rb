# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super

    puts "=========="
    puts "GET /resource/sign_up"
    puts "=========="
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super

    puts "=========="
    puts "GET /resource/sign_up"
    puts "=========="
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # 通常はサインイン後に期限切れになる
  # セッションデータを強制的に今すぐ期限切れにします
  # これは、ユーザーが全てのOAuthセッションデータを削除して、
  #　途中で、oauthサインイン/アップをキャンセルしたい場合に便利です。
  #def cancel
    #super
  #end

  protected

  # 許可するための追加のパラメータがある場合は、sanitizer　に追加してください
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # 許可するための追加のパラメータがある場合は、sanitizer　に追加してください
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # サインアップ後に使用するpath
  def after_sign_up_path_for(resource)
    root_path
  end

  # アクティブでないアカウントのサインアップ後に使用するpath
  def after_inactive_sign_up_path_for(resource)
    root_path
  end
end
