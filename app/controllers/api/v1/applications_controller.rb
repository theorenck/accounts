class API::V1::ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  def index
    @applications = Application.all
    render json: @applications
  end

  def show
    if @application
      render json: @application
    else
      head 404
    end
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      render json: @application, status: 201, location: api_v1_application_url(@application)
    else
      render json: { errors: @application.errors }, status: 422
    end
  end

  def update
    if @application.update(application_params)
      render json: @application, status: 200
    else
      render json: { errors: @application.errors }, status: 422
    end
  end

  def destroy
    @application.destroy
    head 404
  end

  private
    def set_application
      @application = Application.find_by(id: params[:id])
      head 404 unless @application
    end

    def application_params
      params.require(:application).permit(:redirect_uri, :version, :name, :description)
    end

end
