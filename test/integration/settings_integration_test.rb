require 'test_helper'

class SettingsIntegrationTest < ActionDispatch::IntegrationTest
  test 'adding a repository' do
    get '/settings'
    assert_response :success

    post_via_redirect '/settings', settings: { repositories: ['/Users/adam/Music'] }
    assert_equal '/settings', path
    assert_response :success
  end

  test 'removing a respository' do
    get '/settings'
    assert_response :success

    delete_via_redirect '/settings/repositories?index=1'
    assert_response :success

    assert_equal '/settings', path
    assert_equal 1, Settings.repositories.count
  end
end
