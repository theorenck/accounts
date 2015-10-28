class API::V1::OrganizationsController < ApplicationController
  before_action :set_owner, only: [:create]
  before_action :set_organization, only: [:show, :update, :destroy]

  def index
    @organizations = Organization.includes(:owner).all
    render json: @organizations.as_json({include:[:owner]})
  end

  def show
    if @organization
      render json: @organization.as_json({include:[:owner,:members,:service_instances, :applications]})
    else
      head 404
    end
  end

  def create
    @organization = Organization.new(organization_params)

    p organization_params
    if @organization.save
      render json: @organization, status: 201, location: api_v1_organization_url(@organization)
    else
      render json: { errors: @organization.errors }, status: 422
    end
  end

  def update
    if @organization.update(organization_params)
      render json: @organization.as_json({include:[:owner]}), status: 200
    else
      render json: @organization.errors, status: 422
    end
  end

  def destroy
    @organization.destroy
    head :no_content
  end

  private
    def set_organization
      @organization = Organization.includes(:owner, :members, service_instances: [service:[:type]]).find_by(id: params[:id])
      head 404 unless @organization
    end

    def set_owner
      if params[:organization]
        params[:organization][:owner_id] = @authenticated.id
        params[:organization][:memberships_attributes] = []
        params[:organization][:memberships_attributes][0] = {}
        params[:organization][:memberships_attributes][0][:user_id] = params[:organization][:owner_id]
      end
    end

    def organization_params
      params.require(:organization).permit(:id,
        :name,
        :owner_id,
        memberships_attributes: [:user_id],
        services_attributes: [:version, :type_id]
      )
    end
end
