FactoryBot.define do
  factory :period do
    name { 'Mensal' }
    sequence(:months) { |n| n }
  end
end
