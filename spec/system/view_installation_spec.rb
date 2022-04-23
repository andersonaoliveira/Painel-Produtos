require 'rails_helper'
describe 'visualiza instalações' do
  it 'com sucesso' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, product_group: pg)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
    create(:server, capacity: '100', plan: pl)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '3333333333333333'
    create(:server, capacity: '101', plan: pl)
    pr = create(:product, customer: '11451131547', plan: pl, product_code: '1134567890')

    # Act
    login_as(user)
    visit root_path
    click_on 'Instalações'

    # Assert
    within("tr#install-#{pr.id}") do
      expect(page).to have_content 'SRV-3333333333333333'
      expect(page).to have_content '1134567890'
      expect(page).to have_content '11451131547'
      expect(page).to have_content 'active'
      expect(page).to have_content '101'
    end
  end

  it 'com sucesso com 3 servidores com mesma capacidade' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, product_group: pg)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '3333333333333333'
    create(:server, capacity: '100', plan: pl)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
    create(:server, capacity: '100', plan: pl)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '2222222222222222'
    create(:server, capacity: '100', plan: pl)
    create(:product, customer: '11453331547', plan: pl, product_code: '3334567890')

    # Act
    login_as(user)
    visit root_path
    click_on 'Instalações'

    # Assert
    expect(page).to have_content 'SRV-3333333333333333'
    expect(page).to have_content '3334567890'
    expect(page).to have_content '11453331547'
    expect(page).to have_content 'active'
    expect(page).to have_content '100'
  end
end
