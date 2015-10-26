class AddFieldsToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :name, :string
    add_column :audios, :path, :string

    add_index :audios, :name
  end
end
