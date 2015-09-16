class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
	before_action :authenticate

	def page_not_found
    render json: {message: 'Not found'}, status: :not_found
  end

	protected

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @authenticated = User.find_by(token: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="API"'
      render json: {message: 'Bad credentials'}, status: :unauthorized
    end

end
