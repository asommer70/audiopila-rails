class Playlist < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :audios
  
  dragonfly_accessor :image
end
