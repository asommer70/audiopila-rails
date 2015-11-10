require 'rails_helper'

describe 'Displaying Audios' do

  let!(:repositories) { Settings.repositories = ['/Users/adam/Music'] }

  it 'displays a repository' do
    visit '/'

    expect(page).to have_content('/Users/adam/Music')
  end
end
