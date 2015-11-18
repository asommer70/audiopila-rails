class Audio < ActiveRecord::Base
  validates :name, presence: true
  validates :path, presence: true

  belongs_to :album
  has_and_belongs_to_many :playlists
end
