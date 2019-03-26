class Post < ApplicationRecord
  before_save :set_default

  validates_presence_of :title, :image
  validates_length_of :title, minimum: 2, maximum: 30
  validates_length_of :posted_by, minimum: 2, maximum: 30, allow_blank: true
  validates_length_of :caption, minimum: 4, maximum: 280, allow_blank: true

  def set_default
    self.posted_by = "anonymous" unless !self.posted_by.nil?
  end

  mount_base64_uploader :image, PhotoUploader
end
