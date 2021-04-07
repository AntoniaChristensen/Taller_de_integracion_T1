require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get characters_show_url
    assert_response :success
  end

  test "should get search" do
    get characters_search_url
    assert_response :success
  end
end
