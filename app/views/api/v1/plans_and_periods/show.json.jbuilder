json.id @plan.id
json.name @plan.name
json.description @plan.description
json.details @plan.details

json.periods @plan.current_prices do |p|
  json.period p.period.name
  json.months p.period.months
end
