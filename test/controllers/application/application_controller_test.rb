require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  def test_home
    get root_path
    assert_response :ok
    assert_includes response.body, "Add image"
    refute_includes response.body, 'blah'
  end
end
