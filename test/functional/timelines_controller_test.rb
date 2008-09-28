require 'test_helper'

class TimelinesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:timelines)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_timeline
    assert_difference('Timeline.count') do
      post :create, :timeline => { }
    end

    assert_redirected_to timeline_path(assigns(:timeline))
  end

  def test_should_show_timeline
    get :show, :id => timelines(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => timelines(:one).id
    assert_response :success
  end

  def test_should_update_timeline
    put :update, :id => timelines(:one).id, :timeline => { }
    assert_redirected_to timeline_path(assigns(:timeline))
  end

  def test_should_destroy_timeline
    assert_difference('Timeline.count', -1) do
      delete :destroy, :id => timelines(:one).id
    end

    assert_redirected_to timelines_path
  end
end
