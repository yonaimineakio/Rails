class Comment < ApplicationRecord
  default_scope -> {order(created_at: :desc)}
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader
  belongs_to :user
  belongs_to :micropost
end
