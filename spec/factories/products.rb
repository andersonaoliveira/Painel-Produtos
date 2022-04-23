FactoryBot.define do
  factory :product do
    plan_id { 1 }
    product_code { 'QYJKQMGKR9' }
    status { 0 }
    customer { '12345678900' }
  end
end
