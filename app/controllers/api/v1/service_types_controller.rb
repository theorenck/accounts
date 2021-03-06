class API::V1::ServiceTypesController < ApplicationController
  before_action :set_service_type, only: [:show, :update, :destroy]

  def index
    @service_types = ServiceType.all
    render json: @service_types
  end

  def show
    if @service_type
      render json: @service_type.as_json({include:[services:{include:[]}]})
    else
      head 404
    end
  end

  def create
    @service_type = ServiceType.new(service_type_params)

    if @service_type.save
      render json: @service_type, status: 201, location: api_v1_service_type_url(@service_type)
    else
      render json: { errors: @service_type.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @service_type.update(service_type_params)
      render json: @service_type, status: :ok
    else
      render json: { errors: @service_type.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @service_type.destroy
    head :no_content
  end

  private
    def set_service_type
      @service_type = ServiceType.includes(:services).find_by(id: params[:id])
      head 404 unless @service_type
    end

    def service_type_params
      params.require(:service_type).permit(:code, :name, :description)
    end
end
