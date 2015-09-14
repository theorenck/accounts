class API::V1::ApplicationInstancesController < ApplicationController
  before_action :set_application_instance, only: [:show, :edit, :update, :destroy]

  def index
    @application_instances = ApplicationInstance.all
    render json: @application_instances
  end

  def show
    render json: @application_instance
  end

  def create
    @application_instance = ApplicationInstance.new(application_instance_params)

    if @application_instance.save
      render json: @application_instance
    else
      render json: @application_instance.errors, status: :unprocessable_entity
    end
  end

  def update
    if @application_instance.update(application_instance_params)
      render json: @application_instance, status: :ok
    else
      render json: @application_instance.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @application_instance.destroy
    head :no_content
  end

  private
    def set_application_instance
      @application_instance = ApplicationIntance.find(params[:id])
    end

    def application_instance_params
      params.require(:application_instance).permit(:url, :version)
    end

end
