class AddPlabackTimeToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :playback_time, :integer
  end
end
