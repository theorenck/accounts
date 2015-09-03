class OrganizationsController < ApplicationController

  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
    render json: @organizations
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    render json: @user
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    if @organization.update(organization_params)
      render json: @organization, status: :ok
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      # params[:organization]
      params.require(:organization).permit(:name)
    end
end
