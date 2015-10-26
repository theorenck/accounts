# in app/middleware/catch_json_parse_errors.rb
class CatchJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::ParamsParser::ParseError => error
      # if env['HTTP_ACCEPT'] =~ /application\/json/
      # if env['HTTP_ACCEPT'] =~ /.*\/.*/
      if env['HTTP_ACCEPT'] = 'application/json'
        error_output = "There was a problem in the JSON structure you submitted."#: #{error}"
        return [
          422, { "Content-Type" => "application/json" },
          [ { error: error_output }.to_json ]
        ]
      else
        raise error
      end
    end
  end
end
