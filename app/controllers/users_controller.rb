class UsersController < ApplicationController
  before_action :require_admin, only: [:index, :new, :create, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @page_title = "#{I18n.t('users_index.title')} | #{I18n.t('title')}"
  end

  # GET /users/new
  def new
    @user = User.new
    @page_title = "#{I18n.t('add_user.title')} | #{I18n.t('title')}"
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if current_user != @user
      @page_title = "#{I18n.t('edit_user.title')} | #{I18n.t('title')}"
    else
      @page_title = "#{I18n.t('settings.title')} | #{I18n.t('title')}"
    end
    

    if !current_user.admin && current_user != @user
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path }
        format.json { render :index, status: :created}
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if !current_user.admin && current_user != @user
      redirect_to root_path and return
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html {
          if !current_user.admin
            redirect_to root_path
          else
            redirect_to users_url
          end
        }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    if !current_user.admin
      params[:user].delete :admin
    end

    params.require(:user).permit(:username, :password, :password_confirmation, :admin, :locale)
  end
end
