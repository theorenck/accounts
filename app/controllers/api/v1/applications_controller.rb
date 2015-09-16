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
      render json: {message: 'Not found'}, status: :not_found
    end
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      render json: @application
    else
      render json: { errors: @application.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @application.update(application_params)
      render json: @application, status: :ok
    else
      render json: { errors: @application.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @application.destroy
    head :no_content
  end

  private
    def set_application_instance
      @application = Application.find_by(id: params[:id])
    end

    def application_params
      params.require(:application).permit(:url, :version, :name, :code, :description)
    end

end
