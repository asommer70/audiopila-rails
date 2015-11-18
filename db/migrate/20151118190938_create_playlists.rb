class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :image_uid
      t.string :image_name
      #t.integer :audios, index: true

      t.timestamps null: false
    end

    create_join_table :audios, :playlists
  end
end
