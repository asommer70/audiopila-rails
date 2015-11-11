class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.date :year
      t.string :artist
      t.string :genre
      t.references :audios, index: true

      t.timestamps null: false
    end
  end
end
