FactoryBot.define do
  factory :plan do
    name { 'Hospedagem básica' }
    description { 'Plano padrão de hospedagem' }
    details { 'Plano de hospedagem padrão com algumas limitações' }
    product_group { nil }
    status { 0 }
  end
end
