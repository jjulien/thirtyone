json.array!(@local_resource_categories) do |local_resource_category|
  json.extract! local_resource_category, :id, :name
  json.url local_resource_category_url(local_resource_category, format: :json)
end
