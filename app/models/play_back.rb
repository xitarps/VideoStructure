class PlayBack < ApplicationRecord
  mount_uploader :video, VideoUploader
  validates :video, presence: true
  validates :title, presence: true
  validates :url, presence: true
end
