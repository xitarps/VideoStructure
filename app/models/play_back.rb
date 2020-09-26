class PlayBack < ApplicationRecord
  mount_uploader :video, VideoUploader
  belongs_to :user
  validates :title, presence: true
  validates :url, presence: true
end
