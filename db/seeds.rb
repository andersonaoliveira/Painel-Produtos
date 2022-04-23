# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'teste@locaweb.com.br', password: '12345678', administrator: true)
User.create!(email: 'mktdeprodutos@locaweb.com.br', password: '12345678', administrator: false)

pg1 = ProductGroup.new(name: "Email", description: "Serviços de Email", key: "EMAIL")
pg1.icon.attach(io: File.open(Rails.root.join('spec/support/icons/email.png')), filename: 'email.png')
pg1.save

pg2 = ProductGroup.new(name: "Hospedagem", description: "Serviços de hospedagem", key: "HSPDG")
pg2.icon.attach(io: File.open(Rails.root.join('spec/support/icons/cloud.png')), filename: 'cloud.png')
pg2.save

pg3 = ProductGroup.new(name: "Cloud", description: "Serviços de cloud", key: "CLOUD")
pg3.icon.attach(io: File.open(Rails.root.join('spec/support/icons/cloud.png')), filename: 'cloud.png')
pg3.save

pl1 = Plan.create!( name: 'Email Básica', description: 'Email para uso pessoal', details: 'Até 3 contas', product_group_id: 1)
pl2 = Plan.create!( name: 'Email Premium', description: 'Email para pequenas empresas', details: 'Até 10 contas', product_group_id: 1)
pl3 = Plan.create!( name: 'Hospedagem Básica', description: 'Hospedagem basica para uso pessoal', details: '1 Site 250 GB de Armazenamento SSD 1 Conta de Email', product_group_id: 2)
pl4 = Plan.create!( name: 'Hospedagem Premium', description: 'Hospedagem basica para uso pessoal', details: '1 Site 500 GB de Armazenamento SSD 3 Conta de Email', product_group_id: 2)
pl5 = Plan.create!( name: 'Virtualização Básica', description: 'Nuvem para uso pessoal', details: '1 servidor', product_group_id: 3)
pl6 = Plan.create!( name: 'Virtualização Premium', description: 'Nuvem para pequenas empresas', details: 'Até 3 servidores', product_group_id: 3)

p1 = Period.create!(name: 'Mensal', months: '1')
p2 = Period.create!(name: 'Semestral', months: '6')
p3 = Period.create!(name: 'Anual', months: '12')

Price.create!(value: 120.0, period: p1, plan: pl1)
Price.create!(value: 105.0, period: p1, plan: pl1)
Price.create!(value: 300.0, period: p2, plan: pl1)
Price.create!(value: 450.0, period: p3, plan: pl1)
Price.create!(value: 150.0, period: p1, plan: pl2)
Price.create!(value: 340.0, period: p2, plan: pl2)
Price.create!(value: 120.0, period: p1, plan: pl3)
Price.create!(value: 327.9, period: p2, plan: pl3)
Price.create!(value: 340.0, period: p2, plan: pl3)
Price.create!(value: 600.0, period: p3, plan: pl3)
Price.create!(value: 110.5, period: p1, plan: pl4)
Price.create!(value: 120.0, period: p1, plan: pl4)
Price.create!(value: 320.0, period: p2, plan: pl4)
Price.create!(value: 610.0, period: p3, plan: pl4)
Price.create!(value: 100.0, period: p1, plan: pl5)
Price.create!(value: 250.0, period: p2, plan: pl5)
Price.create!(value: 500.0, period: p3, plan: pl5)
Price.create!(value: 150.0, period: p1, plan: pl6)
Price.create!(value: 399.9, period: p2, plan: pl6)
Price.create!(value: 700.0, period: p3, plan: pl6)

Server.create!(capacity: 100, plan: pl1)
Server.create!(capacity: 50, plan: pl2)
Product.create!( plan: pl1, product_code: 'QYJKQMGKR9', customer: '12345678900')
Product.create!( plan: pl2, product_code: 'ABCDEMGKR9', customer: '56781678900')
