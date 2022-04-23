require 'rails_helper'

describe 'Usuário abre a tela inicial' do
  it 'e vê o menu' do
    visit root_path

    expect(page).to have_css('a', text: 'Início')
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Senha'
  end

  it 'e vê os planos disponíveis' do
    # Arrange
    user = create(:user)
    product_group = create(:product_group)
    create(:period, name: 'Mensal')
    create(:plan, name: 'Email', product_group: product_group)

    # Act
    login_as(user)
    visit root_path

    # Assert
    within("tr#group-#{product_group.id}") do
      expect(page).to have_link 'Detalhes'
    end
  end

  it 'e não vê os planos inativos' do
    # Arrange
    user = create(:user)
    product_group = create(:product_group)
    create(:period, name: 'Mensal')
    create(:plan, status: :unavailable, product_group: product_group)
    # Act
    login_as(user)
    visit root_path

    # Assert
    expect(page).not_to have_link 'Hospedagem básica'
  end
end
