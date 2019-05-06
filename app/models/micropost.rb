class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :image_size

  # アップロードされた画像のサイズをバリデーションする
  def image_size
    if image.size > 5.megabytes
      errors.add(image: "should be less then 5MB")
    end
  end
end
