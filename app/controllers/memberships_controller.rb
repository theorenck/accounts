class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]


  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      render json: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      # p params
      params[:membership][:organization_id] = params[:organization_id]
      params.require(:membership).permit(:user_id, :organization_id)
    end
end
