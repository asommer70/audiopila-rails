class AdjustAudiosPlaylists < ActiveRecord::Migration
  def change
    drop_table :audios_playlists

    create_table :audios_playlists do |t|
      t.integer :audio_id,    null: false
      t.integer :playlist_id, null: false
      t.integer :playlist_order

      t.timestamps null: false
    end
  end
end
