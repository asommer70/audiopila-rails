class Album < ActiveRecord::Base
  validates :name, presence: true
  validates :artist, presence: true

  has_many :audios, -> { order 'album_order asc' }

  dragonfly_accessor :image
end
