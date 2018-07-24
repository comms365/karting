require 'test_helper'
# :nodoc:

class UserSiteSessionsControllerTest < ActionController::TestCase
  # test case
  setup do
    @user_site_session = user_site_sessions(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_site_sessions)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create user_site_session' do
    assert_difference('UserSiteSession.count') do
      post :create, user_site_session: {
        lap_time: @user_site_session.lap_time,
        session_date: @user_site_session.session_date,
        weather: @user_site_session.weather
      }
    end

    assert_redirected_to user_site_session_path(assigns(:user_site_session))
  end

  test 'should show user_site_session' do
    get :show, id: @user_site_session
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @user_site_session
    assert_response :success
  end

  test 'should update user_site_session' do
    patch :update, id: @user_site_session, user_site_session: {
      lap_time: @user_site_session.lap_time,
      session_date: @user_site_session.session_date,
      weather: @user_site_session.weather
    }
    assert_redirected_to user_site_session_path(assigns(:user_site_session))
  end

  test 'should destroy user_site_session' do
    assert_difference('UserSiteSession.count', -1) do
      delete :destroy, id: @user_site_session
    end

    assert_redirected_to user_site_sessions_path
  end
end
