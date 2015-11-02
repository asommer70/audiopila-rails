require 'test_helper'

class AudioTest < ActiveSupport::TestCase
  test 'an audio should have a name' do
    audio = Audio.new
    assert !audio.save
    assert !audio.errors[:name].empty?
  end

  test 'an audio should have a path' do
    audio = Audio.new
    assert !audio.save
    assert !audio.errors[:path].empty?
  end

  test 'an audio is valid with name and path' do
    audio = Audio.new(name: 'test.mp3', path: './test.mp3')
    assert audio.save
  end
end
