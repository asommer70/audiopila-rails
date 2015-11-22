class ThirdTryPlaylistAudios < ActiveRecord::Migration
  def change
    drop_table :playlist_audios

    create_table :playlist_audios do |t|
      t.belongs_to :playlist, index: true
      t.belongs_to :audio, index: true
      t.integer :playlist_order

      t.timestamps null: false
    end
  end
end
