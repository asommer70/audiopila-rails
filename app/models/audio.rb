class Audio < ActiveRecord::Base
  validates :name, presence: true
  validates :path, presence: true

  belongs_to :album
end
