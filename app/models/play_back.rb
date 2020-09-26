class PlayBack < ApplicationRecord
  mount_uploader :video, VideoUploader
  validates :title, presence: true
  validates :url, presence: true
end
