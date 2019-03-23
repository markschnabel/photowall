class Post < ApplicationRecord
  validates_presence_of :title, :image
  validates_length_of :title, minimum: 2, maximum: 21
  validates_length_of :posted_by, minimum: 2, maximum: 21, allow_blank: true
  validates_length_of :caption, minimum: 5, maximum: 280, allow_blank: true

  mount_base64_uploader :image, PhotoUploader
end
