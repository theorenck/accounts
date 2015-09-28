class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
	before_action :authenticate

	protected

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|

        begin
          @authenticated = User.find_by(token: token)
          unless @authenticated.activated
            render_not_activated
          else
            @authenticated
          end
        rescue => exception
          render_unauthorized
        end

      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="API"'
      render json: {message: 'Bad credentials'}, status: :unauthorized
    end

    def render_not_activated
      render json: {message: 'User not activated'}, status: :unauthorized
    end

end
