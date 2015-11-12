class RenameAlbumsAudiosId < ActiveRecord::Migration
  def change
    rename_column :albums, :audios_id, :audios
  end
end
