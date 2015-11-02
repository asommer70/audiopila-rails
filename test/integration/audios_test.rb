require 'test_helper'

class AudiosTest < ActionDispatch::IntegrationTest
  test 'that a repository is displayed' do
    get '/'

    assert_select '.repo-path', '~/Music'
  end

  test 'that repository will sync' do
    post_via_redirect "/audios", audio: { name: 'test2.mp3', path: '~/Music/test2.mp3' }

    get '/sync_repo/0'
    assert_response :redirect

    get '/'

    assert_select "ul.audio-list" do
      assert_select 'li', 2
    end
  end
end
