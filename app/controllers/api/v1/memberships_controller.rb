class API::V1::MembershipsController < ApplicationController

  before_action :set_membership, only: [:update, :destroy, :activate, :integration]

  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      render json: @membership, status: 201
    else
      render json: { errors: @membership.errors }, status: 422
    end
  end

  def activate
    head 200 if @membership.active?
    @membership.activate
    head 200
  end

  def pending
    @memberships = Membership.joins(:organization).where(active: false, :organizations => {:owner_id => @authenticated.id })
    return head 404 if @memberships.empty?
    render json: @memberships.as_json({include: :user}), status: 200
  end

  def destroy
    if @membership.organization.owned_by @authenticated.id
      @membership.destroy
      head :no_content
    else
      head 403
    end
  end

  def integration
    @service = @membership.organization.find_service('v1','middleware')
    return if update_integration(@service, params[:username], params[:password])
    head 200
  end

  private
    def set_membership
      @membership = Membership.find_by(id: params[:id])
      head 404 unless @membership
    end

    def membership_params
      params[:membership][:organization_id] = params[:organization_id]
      params.require(:membership).permit(:user_id, :organization_id)
    end

    def update_integration(service, username, password)
      response = middleware_authentication(service.uri+'/api/v1/authentication', username, password)

      case response
      when Net::HTTPOK
        @membership.integration = response.body
        @membership.active = true
        head 200 if @membership.save
      else
        head response.code
      end
    end

    def middleware_authentication(location, username, password)
      uri = URI(location)
      request = Net::HTTP::Post.new(uri)
      request.set_form_data('username' => username, 'password' => password)

      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end
    end
end
