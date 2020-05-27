require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  def test_home
    get '/application/home'
    assert_response :ok
    assert_includes response.body, "Welcome to ropes, Sandip"
    refute_includes response.body, 'blah'
  end
end
