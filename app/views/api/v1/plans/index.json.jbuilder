json.array! @plans do |plan|
  json.id plan.id
  json.name plan.name
  json.details plan.details
  json.set! :product_group do
    json.set! :name, plan.product_group.name
    json.set! :key, plan.product_group.key
  end
end
