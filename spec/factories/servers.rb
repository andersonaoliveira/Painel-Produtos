FactoryBot.define do
  factory :server do
    capacity { 100 }
    code { 'SRV-1234567812345678' }
    plan_id { 1 }
  end
end
