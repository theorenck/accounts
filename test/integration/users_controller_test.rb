require 'test_helper'
require 'uri'
require 'net/http'
require 'json'

class UsersControllerTest < ActionController::TestCase

  setup do
    @url = URI("http://127.0.0.1:3000/api/v1/users")
    @http = Net::HTTP.new(@url.host, @url.port)

    # @request["content-type"] = 'application/json'
    # @request["cache-control"] = 'no-cache'
    # @request["postman-token"] = '6f6f4cd7-ed0a-ab6f-44e8-3adaf8a1eb5e'
  end

  # def test_get_with_token
  #   @request = Net::HTTP::Get.new(@url)
  #   @request["authorization"] = 'Token token=3c897fa3098770eef3ed71e314d4c2b1'
  #
  #   response = @http.request(@request)
  #   p '[1] '+response.code
  #   assert_equal '200', response.code
  #   # assert_response :success
  # end
  #
  # def test_get_without_token
  #   @request = Net::HTTP::Get.new(@url)
  #
  #   response = @http.request(@request)
  #   p '[2] '+response.code
  #   assert_equal '401', response.code
  # end

  def test_post_user
    @request = Net::HTTP::Post.new(@url)
    # @request["content-type"] = 'application/json'
    # @request["cache-control"] = 'no-cache'
    # @request["postman-token"] = '6f6f4cd7-ed0a-ab6f-44e8-3adaf8a1eb5e'

    user = { username: "ivoneijr", password: "ivoneijr", email: "ivoneijr@gmail.com" }
    @request.body = URI.encode_www_form(user)

    response = @http.request(@request)
    p '[3] '+response.code
  end

end
