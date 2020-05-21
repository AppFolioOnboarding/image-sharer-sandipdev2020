require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  def test_home
    get root_path
    assert_response :ok
    #pp response.body
    assert_includes response.body, "Welcome to ropes"
    refute_includes response.body, 'blah'
  end
end
