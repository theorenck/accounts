class API::V1::AccountsController < ApplicationController

  def index
    @accounts = Application.all
    render json: @accounts
  end

end
