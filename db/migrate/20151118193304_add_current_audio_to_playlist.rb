class AddCurrentAudioToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :current_audio, :integer, index: true
  end
end
