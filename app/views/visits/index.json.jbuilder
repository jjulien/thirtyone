json.array!(@visits) do |visit|
  json.extract! visit, :id
  json.url visit_url(visit, format: :json)
end
