json.extract! rental, :id, :user_id, :product_id, :start_date, :end_date, :created_at, :updated_at
json.url rental_url(rental, format: :json)
