# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  #ここは config/initializers/devise.rb　で config.sign_out_via =:get としているため DELETEではなく GET
  def destroy
    super
  end

  protected
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # 許可するための追加のパラメータがある場合は、sanitizer　に追加してください
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
