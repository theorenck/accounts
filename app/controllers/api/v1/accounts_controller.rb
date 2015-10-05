class API::V1::AccountsController < ApplicationController

  def index
    @accounts = Account.all
    render json: @accounts
  end

end
