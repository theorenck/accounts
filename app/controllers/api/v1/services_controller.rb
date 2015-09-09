class API::V1::ServicesController < ApplicationController
  before_action :set_service, only: [:show, :update, :destroy]

  def index
    @services = Service.all
    render json: @services
  end

  def show
    render json: @user
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      render json: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      render json: @service, status: :ok
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    head :no_content
  end

  private
    def set_service
      @service = Service.find(params[:id])
    end

    def service_params
      # params[:service]
      params.require(:service).permit(:name, :description, :url, :organization_id, :type_id)
    end
end