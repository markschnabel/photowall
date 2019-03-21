json.extract! post, :id, :title, :image, :posted_by, :caption, :created_at, :updated_at
json.url post_url(post, format: :json)
