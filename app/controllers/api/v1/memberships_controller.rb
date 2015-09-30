class API::V1::MembershipsController < ApplicationController

  before_action :set_authorized, only: [:create, :destroy]
  before_action :set_membership, only: [:edit, :update, :destroy]

  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      render json: @membership
    else
      render json: { errors: @membership.errors }, status: :unprocessable_entity
    end
  end

  def authorize
    @membership = Membership.find_by(id: params[:token])
    unless @membership.authorized?
      @membership.authorize
      render json: {message: 'Authorization success'}, status: 200
    else
      render json: {message: 'Not found'}, status: 404
    end
  end

  def pending
    @memberships = Membership.joins(:organization).where(authorized: false, :organizations => {:owner_id => @authenticated.id })
    render json: @memberships.as_json({include: :user})
  end

  def destroy
    if @authenticated_is_owner
      @membership.destroy
      head :no_content
    else
      render json: { message: 'Not authorized'}, status: 203
    end
  end

  private
    def set_membership
      @membership = Membership.find_by(id: params[:id])
    end

    def set_authorized
      organization = Organization.find_by(id: params[:organization_id])
      if organization.owned_by @authenticated.id
        @authenticated_is_owner = params[:membership][:authorized] = true
      end
    end

    def membership_params
      params[:membership][:organization_id] = params[:organization_id]
      params.require(:membership).permit(:user_id, :organization_id, :authorized)
    end
end
