FactoryBot.define do
  factory :product_group do
    name { 'Email' }
    description { 'Email básico para acesso.' }
    sequence(:key, [*'A'..'Z'].cycle) { |n| "EMAI#{n}" }

    before(:create) do |product_group|
      product_group.icon.attach(io: File.open(Rails.root.join('spec', 'support', 'icons',
                                                              "#{product_group.name.downcase}.png")),
                                filename: "#{product_group.name.downcase}.png",
                                content_type: 'image/png')
    end
  end
end
