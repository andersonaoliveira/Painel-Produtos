json.array! @periods do |period|
  json.id period.id
  json.name period.name
  json.months period.months
end
