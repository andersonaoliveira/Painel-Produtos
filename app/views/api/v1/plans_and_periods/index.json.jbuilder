json.array! @plans do |plan|
  json.id plan.id
  json.name plan.name

  json.periods plan.current_prices do |p|
    json.period p.period.name
    json.months p.period.months
  end
end
