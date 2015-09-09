class API::V1::ServiceTypesController < ApplicationController
  before_action :set_service_type, only: [:show, :update, :destroy]

  def index
    @service_types = ServiceType.all
    render json: @service_types
  end

  def show
    render json: @service_type
  end

  def new
    @service_type = ServiceType.new
  end

  def create
    @service_type = ServiceType.new(service_type_params)

    if @service_type.save
      render json: @service_type
    else
      render json: @service_type.errors, status: :unprocessable_entity
    end
  end

  def update
    if @service_type.update(service_type_params)
      render json: @service_type, status: :ok
    else
      render json: @service_type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @service_type.destroy
    head :no_content
  end

  private
    def set_service_type
      @service_type = ServiceType.find(params[:id])
    end

    def service_type_params
      # params[:service_type]
      params.require(:service_type).permit(:name, :description)
    end
end