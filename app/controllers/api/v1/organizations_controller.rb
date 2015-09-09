class API::V1::OrganizationsController < ApplicationController
  before_action :set_owner, only: [:create]
  before_action :set_organization, only: [:show, :update, :destroy]

  def index
    @organizations = Organization.all
    render json: @organizations
  end

  def show
    render json: @organization
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def update
    if @organization.update(organization_params)
      render json: @organization, status: :ok
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy
    head :no_content
  end

  private
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def set_owner
      params[:organization][:owner_id] = @authenticated.id
      params[:organization][:memberships_attributes] = []
      params[:organization][:memberships_attributes][0] = {}
      params[:organization][:memberships_attributes][0][:user_id] = params[:organization][:owner_id]
    end

    def organization_params
      params.require(:organization).permit(:id,
        :name,
        :owner_id,
        memberships_attributes: [:user_id],
        services_attributes: [:name,
          :description,
          :url,
          :organization_id,
          :type_id
        ]
      )
    end
end