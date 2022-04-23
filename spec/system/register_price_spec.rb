require 'rails_helper'

describe 'Registra preço para plano e período' do
  it 'com sucesso' do
    # Arrange
    user = create(:user)
    product_group = create(:product_group)
    create(:period, name: 'Mensal')
    create(:period, name: 'Trimestral')
    plan = create(:plan, name: 'Email', product_group: product_group)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{plan.id}") do
      click_on 'Detalhes'
    end
    fill_in 'Valor', with: '100'
    select 'Mensal', from: 'Período'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Preço cadastrado com sucesso.'
    expect(page).to have_content 'Plano: Email'
    expect(page).to have_content 'R$ 100,00'
  end

  it 'e não preenche o preço' do
    # Arrange
    user = create(:user)
    product_group = create(:product_group)
    create(:period, name: 'Mensal')
    plan = create(:plan, name: 'Email', product_group: product_group)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{plan.id}") do
      click_on 'Detalhes'
    end
    fill_in 'Valor', with: ''
    select 'Mensal', from: 'Período'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Valor deve ser maior que 0'
  end
end
