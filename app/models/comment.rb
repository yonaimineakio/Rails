class Comment < ApplicationRecord
  default_scope -> {order(created_at: :desc)}
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :micropost
end
