require 'test_helper'

class AudiosControllerTest < ActionController::TestCase
  setup do
    @audio = audios(:test)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:audios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create audio" do
    assert_difference('Audio.count') do
      post :create, audio: { name: 'test3.mp3', path: '~/Music' }
    end

    assert_redirected_to audio_path(assigns(:audio))
  end

  test "should show audio" do
    get :show, id: @audio
    assert_response :success
    assert_select 'audio'
  end

  test "should get edit" do
    get :edit, id: @audio
    assert_response :success
  end

  test "should update audio" do
    patch :update, id: @audio, audio: {  }
    assert_redirected_to audio_path(assigns(:audio))
  end

  test "should destroy audio" do
    assert_difference('Audio.count', -1) do
      delete :destroy, id: @audio
    end

    assert_redirected_to audios_path
  end
end
