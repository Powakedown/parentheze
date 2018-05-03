require 'test_helper'

class LettersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get letters_index_url
    assert_response :success
  end

end
