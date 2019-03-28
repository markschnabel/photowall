# Post schema here for reference:
#
# t.string "title"
# t.string "image"
# t.string "posted_by"
# t.text "caption"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
include ActionDispatch::TestProcess

FactoryBot.define do
  factory :post, class: Post do
    title { "title" }
    image { fixture_file_upload(Rails.root + "spec/fixtures/files/test_image.jpeg", "image/jpeg") }
    posted_by { "name" }
    caption { "caption" }
  end
end
