class RenameAudiosPlaylists < ActiveRecord::Migration
  def change
    rename_table :audios_playlists, :playlist_audios
  end
end
