json.array! @product_groups do |product_group|
  json.id product_group.id
  json.name product_group.name
  json.key product_group.key
  json.description product_group.description
  json.icon url_for(product_group.icon)
end
