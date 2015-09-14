class API::V1::UsersController < ApplicationController

  before_action :authenticate, except: [:create, :signin]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user.as_json({include:[:organizations,:authorizations]})
  end

  def me
    render json: @authenticated.as_json({include:[:organizations,:authorizations]})
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def signin
    @signin = SignIn.new(signin_params)

    if @signin.save
      render json: @signin, status: :created
    else
      render json: { errors: @signin.errors }, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.includes(organizations: [:owner]).find(params[:id])
    end

    def signin_params
      params[:user][:remote_ip] = request.remote_ip
      params.require(:user).permit(:username, :password, :remote_ip)
    end

    def user_params
      params.require(:user).permit(:username, :password, :email)
    end
end
