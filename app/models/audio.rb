class Audio < ActiveRecord::Base
  validates :name, presence: true
  validates :path, presence: true

  belongs_to :album
  has_many :playlist_audios
  has_many :playlists, through: :playlist_audios
  #has_many :playlists, :class_name => 'PlaylistAudios', :foreign_key => 'audio_id'

end
