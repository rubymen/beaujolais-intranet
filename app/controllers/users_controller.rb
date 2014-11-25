class UsersController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, User
    @users = User.all
    respond_with(@users)
  end

  def show
    authorize! :read, User
    respond_with(@user)
  end

  def new
    authorize! :create, User
    @user = User.new
    respond_with(@user)
  end

  def edit
    authorize! :update, User
  end

  def create
    authorize! :create, User
    @user = User.new user_params

    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    authorize! :update, User
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    authorize! :destroy, User
    @user.destroy
    respond_with(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :type)
  end
end
