class Post < ApplicationRecord
  before_validation :set_default

  validates_presence_of :title, :image
  validates_length_of :title, minimum: 4, maximum: 30
  validates_length_of :posted_by, minimum: 4, maximum: 30, allow_blank: true
  validates_length_of :caption, minimum: 4, maximum: 280, allow_blank: true

  def set_default
    if self.posted_by.nil? || self.posted_by.empty?
      self.posted_by = "anonymous"
    end
    if self.caption.nil? || self.caption.empty?
      self.caption = "(no caption)"
    end
  end

  mount_base64_uploader :image, PhotoUploader
end
