require 'test_helper'

class SettingsTest < ActiveSupport::TestCase
  test 'a setting is saved' do
    Settings.repositories = '/home/adam/Music'
    Settings.save

    assert !Settings.where(var: 'repositories').empty?
  end
end
