json.extract! play_back, :id, :title, :url, :views, :created_at, :updated_at
json.url play_back_url(play_back, format: :json)
