json.array!(@local_resources) do |local_resource|
  json.extract! local_resource, :id, :contact_name, :business_name, :phone, :email, :url, :address
  json.url local_resource_url(local_resource, format: :json)
end
