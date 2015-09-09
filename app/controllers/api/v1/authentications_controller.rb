class API::V1::AuthenticationsController < ApplicationController

  before_action :authenticate, except: :create

  # POST /authentications
  def create
    @authentication = Authentication.new(authentication_params)

    if @authentication.save
      render json: @authentication, status: :created
    else
      render json: { errors: @authentication.errors }, status: :unprocessable_entity
    end
  end

  private

    def authentication_params
      params[:authentication][:remote_ip] = request.remote_ip
      params.require(:authentication).permit(:username, :password, :remote_ip)
    end
end
