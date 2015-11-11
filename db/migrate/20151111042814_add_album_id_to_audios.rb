class AddAlbumIdToAudios < ActiveRecord::Migration
  def change
    add_reference :audios, :album, index: true, foreign_key: true
  end
end
