class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      render json: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @membership.destroy
    head :no_content
  end

  private

    def set_membership
      @membership = Membership.find(params[:id])
    end

    def membership_params
      params[:membership][:organization_id] = params[:organization_id]
      params.require(:membership).permit(:user_id, :organization_id)
    end
end
