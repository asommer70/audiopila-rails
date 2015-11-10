require 'rails_helper'

describe 'Destroy Settings' do
  let!(:repositories) { Settings.repositories = ['~Music'] }

  it 'removes a repository' do
    visit '/settings'

    repo_count = Settings.repositories.count

    find('#repo_0').click

    expect(Settings.repositories.count).to eq(repo_count - 1)
  end
end
