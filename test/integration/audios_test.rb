require 'test_helper'

class AudiosTest < ActionDispatch::IntegrationTest
  test 'that a repository is displayed' do
    get '/'

    assert_select '.repo-path', '~/Music'
  end

  test 'that repository will sync' do
    fixtures_repo = Rails.root.join('test', 'fixtures', 'repo')
    post_via_redirect '/settings', settings: { repositories: [fixtures_repo] }
    unless File.exists?(fixtures_repo)
      Dir.mkdir(fixtures_repo)
      `touch #{fixtures_repo + 'test.mp3'}`
      `touch #{fixtures_repo + 'test2.mp3'}`
    end

    post_via_redirect "/audios", audio: { name: 'test2.mp3', path: '../fixtures/repo/test2.mp3' }
    puts "Audios.last: #{Audio.last.inspect}"

    puts "Settings.repositories: #{Settings.repositories}"

    repo = Settings.repositories.index(fixtures_repo)
    puts "repo: #{repo}"
    get '/sync_repo/' + repo.to_s
    assert_response :redirect

    get '/'

    puts "Settings.repositories: #{Settings.repositories}"

    assert_select "##{repo}"
    assert_select "##{repo}" do
      assert_select 'li', 2
    end
    FileUtils.rm_rf(fixtures_repo)
  end
end
