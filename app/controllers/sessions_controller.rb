class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:alert] = I18n.t('login.error')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end
