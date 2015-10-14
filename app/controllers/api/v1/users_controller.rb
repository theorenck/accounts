class API::V1::UsersController < ApplicationController
  before_action :authenticate, except: [:create, :signin, :activation, :retrieve_password]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    if @user
      render json: @user.as_json({include:[:organizations,:authorizations]})
    else
      head 404
    end
  end

  def create
    p ':::::::::::::'
    p params
    p ':::::::::::::'
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def me
    render json: @authenticated.as_json({include:[:organizations,:authorizations]})
  end

  def signin
    @signin = SignIn.new(signin_params)

    if @signin.save
      render json: @signin, status: :created
    else
      render json: { errors: @signin.errors }, status: :unprocessable_entity
    end
  end

  def activation
    @active_user = ActiveUser.new(activation_token: params[:activation_token])
    if @active_user.active
      render json: {message: 'Activation success'}, status: 200
    else
      head 404
    end
  end

  def retrieve_password
    @password_retrieval = PasswordRetrieval.new(password_retrieval_params)
    if @password_retrieval.retrieve
      render json: {message: 'Recovered password sent to the registered email'}, status: 200
    else
      head 404
    end
  end

  private
    def set_user
      @user = User.includes(organizations: [:owner]).find_by(id: params[:id])
      head 404 unless @user
    end

    def password_retrieval_params
      params.require(:user).permit(:email)
    end

    def signin_params
      params[:user][:remote_ip] = request.remote_ip
      params.require(:user).permit(:username, :password, :remote_ip)
    end

    def user_params
      params.require(:user).permit(:username, :password, :email)
    end

end
