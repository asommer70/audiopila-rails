class AddImageToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :image_uid,  :string
    add_column :albums, :image_name, :string
  end
end
