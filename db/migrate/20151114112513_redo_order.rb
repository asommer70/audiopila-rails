class RedoOrder < ActiveRecord::Migration
  def change
    remove_column :albums, :order
    add_column :audios, :album_order, :integer
  end
end
