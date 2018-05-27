class Film < ApplicationRecord
  belongs_to :user
  has_many :film_tag
  has_many :tags, through: :film_tag
  accepts_nested_attributes_for :tags
  has_many :likes
  has_many :comments

  mount_uploader :film_image, ImageUploader

  validates :user_id,
    presence: true

  validates :title,
    presence: true,
    length: { maximum: 255 }

  validates :staff,
    length: { maximum: 255 }

  validates :cinema,
    length: { maximum: 100 }
end
