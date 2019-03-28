# Post schema here for reference:
#
# t.string "title"
# t.string "image"
# t.string "posted_by"
# t.text "caption"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
require "rails_helper"

RSpec.describe Post, :type => :model do
  before(:each) {
    @post = FactoryBot.create(:post)
  }

  context "creation tests" do
    # Ensure that a post with 100% valid fields can be added to the database
    it "should save a new post to the database as the input is valid" do
      expect(@post.save).to eq(true)
      expect(Post.all.count).to eq(1)
    end
  end

  context "validation tests" do
    # Tests for title validation
    it "ensures presence of title" do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    # Tests for image validation
    it "ensures presence of image" do
      @post.image = "nil"
      expect(@post).to_not be_valid
    end

    # Tests for posted_by validation
    it "ensures posted_by must be longer than 4 characters if provided" do
      @post.posted_by = "1"
      expect(@post).to_not be_valid
    end

    it "ensures posted_by is allowed to be blank" do
      @post.posted_by = nil
      expect(@post).to be_valid
    end

    # Tests for caption validation
    it "ensures caption must be longer than 4 characters if provided" do
      @post.caption = "1"
      expect(@post).to_not be_valid
    end

    it "ensures caption is allowed to be blank" do
      @post.posted_by = nil
      expect(@post).to be_valid
    end
  end
end
