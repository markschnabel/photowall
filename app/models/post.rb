class Post < ApplicationRecord
  validates_presence_of :title, :image
  validates_length_of :title, minimum: 4, maximum: 20
  validates_length_of :posted_by, minimum: 4, maximum: 30, allow_blank: true
  validates_length_of :caption, minimum: 4, maximum: 280, allow_blank: true

  mount_base64_uploader :image, PhotoUploader
end
