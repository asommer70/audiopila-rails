class AddCurrentAudioToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :current_audio, :integer, index: true
  end
end
