json.extract! post, :id, :question, :latitude, :longitude, :user_id, :active, :emjoi, :created_at, :updated_at
json.url post_url(post, format: :json)
