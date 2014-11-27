class UsersController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, except: [:new, :create, :new_password]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :reset]

  def index
    authorize! :read, User
    @users = User.all
    respond_with(@users)
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

    respond_to do |format|
      format.html do
        if @user.save
          redirect_to users_path
        else
          render 'new'
        end
      end

      format.json do
        if @user.save
          render json: @user, status: 200 and return
        else
          render json: @user, status: 400 and return
        end
      end
    end
  end

  def update
    authorize! :update, User
    @user.update(user_params)
    respond_to do |format|
      format.html do
        if @user.save
          redirect_to users_path
        else
          render 'edit'
        end
      end

      format.json do
        if @user.save
          render json: @user, status: 200 and return
        else
          render json: @user, status: 400 and return
        end
      end
    end
  end

  def new_password
    current_user.reset_password!(params[:user][:password], params[:user][:password_confirmation])
  end

  def reset
    authorize! :update, User
    respond_to do |format|
      format.html do
        @user.send_reset_password_instructions
        redirect_to users_path
      end

      format.json do
        if @user.send_reset_password_instructions
          render json: @user, status: 200 and return
        else
          render json: @user, status: 400 and return
        end
      end
    end
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
