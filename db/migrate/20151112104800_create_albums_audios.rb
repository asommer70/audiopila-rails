class CreateAlbumsAudios < ActiveRecord::Migration
  def change
    create_table :albums_audios do |t|
      t.belongs_to :album, index: true
      t.belongs_to :audio, index: true
    end
  end
end
