require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  def setup
    @user = users(:user)
  end

  test "user should be redirected to root" do
    get :new
    assert_redirected_to root_url
  end
end
