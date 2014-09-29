json.array!(@room_factors) do |room_factor|
  json.extract! room_factor, :id
  json.url room_factor_url(room_factor, format: :json)
end
