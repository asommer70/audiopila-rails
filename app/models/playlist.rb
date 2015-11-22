class Playlist < ActiveRecord::Base
  validates :name, presence: true

  has_many :playlist_audios
  has_many :audios, -> { order 'playlist_audios.playlist_order' }, through: :playlist_audios

  dragonfly_accessor :image
  #accepts_nested_attributes_for :audios
end
