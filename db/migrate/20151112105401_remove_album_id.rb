class RemoveAlbumId < ActiveRecord::Migration
  def change
    remove_reference :audios, :album, index: true, foreign_key: true
    add_column :audios, :album_id, :integer, index: true
  end
end
