require 'test_helper'
# :nodoc:
class SiteControllerTest < ActionController::TestCase
  # test case
  test 'should get index' do
    get :index
    assert_response :success
  end
end
