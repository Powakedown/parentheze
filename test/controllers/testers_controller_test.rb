require 'test_helper'

class TestersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get testers_create_url
    assert_response :success
  end

end
