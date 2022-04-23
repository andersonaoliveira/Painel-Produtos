require 'rails_helper'

describe 'Usuário ve servidores' do
  it 'com sucesso' do
    # Arrange
    user = create(:user)
    product_group = create(:product_group)
    create(:period, name: 'Mensal')
    plan = create(:plan, name: 'Email', product_group: product_group)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
    sv1 = create(:server, capacity: '100', plan: plan)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '2222222222222222'
    sv2 = create(:server, capacity: '200', plan: plan)

    # Act
    login_as(user)
    visit root_path
    click_on 'Servidores'

    # Assert
    # Assert
    within("tr#server-#{sv1.id}") do
      expect(page).to have_link 'Detalhes'
      expect(page).to have_content 'SRV-1111111111111111'
    end
    within("tr#server-#{sv2.id}") do
      expect(page).to have_link 'Detalhes'
      expect(page).to have_content 'RV-2222222222222222'
    end
  end
end
