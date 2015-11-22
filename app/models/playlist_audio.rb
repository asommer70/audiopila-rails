class PlaylistAudio < ActiveRecord::Base
  belongs_to :audio
  belongs_to :playlist
end
