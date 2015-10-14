class API::V1::MembershipsController < ApplicationController

  before_action :set_activated,  only: [:create, :destroy]
  before_action :set_membership, only: [:update, :destroy, :activate, :legacy_integration]

  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      render json: @membership
    else
      render json: { errors: @membership.errors }, status: :unprocessable_entity
    end
  end

  def activate
    head 200 if @membership.active?
    @membership.activate
    head 200
  end

  def pending
    @memberships = Membership.joins(:organization).where(active: false, :organizations => {:owner_id => @authenticated.id })
    render json: @memberships.as_json({include: :user})
  end

  def destroy
    if @authenticated_is_owner
      @membership.destroy
      head :no_content
    else
      head 403
    end
  end

  def legacy_integration
    @membership.legacy_integration = request.raw_post
    if @membership.save
      head 200
    else
      head 422
    end
  end

  private
    def set_membership
      @membership = Membership.find_by(id: params[:id])
      head 404 unless @membership
    end

    def set_activated
      organization = Organization.find_by(id: params[:organization_id])
      if organization.owned_by @authenticated.id
        @authenticated_is_owner = params[:membership][:activated] = true
      end
    end

    def membership_params
      params[:membership][:organization_id] = params[:organization_id]
      params.require(:membership).permit(:user_id, :organization_id, :activated)
    end

end
