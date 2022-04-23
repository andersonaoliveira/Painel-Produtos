json.array! @prices do |price|
  json.id price.id
  json.plan price.plan.name
  json.value price.value
  json.period price.period.name
end
