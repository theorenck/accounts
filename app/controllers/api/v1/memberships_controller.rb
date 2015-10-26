class API::V1::MembershipsController < ApplicationController

  before_action :set_activated,  only: [:create, :destroy]
  before_action :set_membership, only: [:update, :destroy, :activate, :integration]

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

  def integration
    @username = params[:username]
    @password = params[:password]
    @location = get_location(@membership)

    # request = Net::HTTP::Post.new(@location)
    # request.set_form_data('username' => @username, 'password' => @password)
    #
    # response = Net::HTTP.start(@location.hostname, @location.port) do |http|
    #   http.request(request)
    # end
    #
    # if response.code == '200'
    #   @membership.legacy_integration = response.body
    #   head 200 if @membership.save
    # else
    #   head 422
    # end

    head 200
  end

  private
    def set_membership
      @membership = Membership.find_by(id: params[:id])
      head 404 unless @membership
    end

    def set_activated
      organization = Organization.find_by(id: params[:organization_id])
      if organization.owned_by @authenticated.id
        @authenticated_is_owner = params[:membership][:active] = true
      end
    end

    def membership_params
      params[:membership][:organization_id] = params[:organization_id]
      params.require(:membership).permit(:user_id, :organization_id, :active)
    end

    def get_location(membership)
        @service_type = ServiceType.find_by(code: 'middleware')
        @service_instance = membership.organization.service_instances
        p '-------------------------------'
        p @service_instance
        # @service = @service_instance.service
        #
        # @location = @service_instance.uri+'/api/'+@service.version+'/authentication'
        # p @location
        p '-------------------------------'

    end

end
