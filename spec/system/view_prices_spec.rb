require 'rails_helper'

describe 'Usuário visualiza preço para plano e período, atual e antigos' do
  it 'com sucesso' do
    # Arrange
    user = create(:user)
    product_group = create(:product_group)
    period = create(:period, name: 'Mensal')
    plan = create(:plan, name: 'Email', product_group: product_group)
    price1 = create(:price, value: 150.0, plan: plan, period: period)
    price2 = create(:price, value: 165.0, plan: plan, period: period)
    create(:price, value: 170.0, plan: plan, period: period)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{plan.id}") do
      click_on 'Detalhes'
    end

    # Assert
    within('tr#current-price') do
      expect(page).not_to have_content 'R$ 165,00'
      expect(page).to have_content 'R$ 170,00'
    end

    within("tr#old-price#{price1.id}") do
      expect(page).to have_content 'R$ 150,00'
    end

    within("tr#old-price#{price2.id}") do
      expect(page).to have_content 'R$ 165,00'
    end
  end

  it 'e visualiza o usuário que criou o preço' do
    # Arrange
    user = create(:user, email: 'teste@locaweb.com.br')
    product_group = create(:product_group)
    period = create(:period, name: 'Mensal')
    plan = create(:plan, name: 'Email', product_group: product_group)
    price1 = create(:price, value: 150.0, plan: plan, period: period, registered_by: 'teste@locaweb.com.br')
    price2 = create(:price, value: 165.0, plan: plan, period: period, registered_by: 'teste@locaweb.com.br')
    create(:price, value: 170.0, plan: plan, period: period, registered_by: 'teste@locaweb.com.br')

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{plan.id}") do
      click_on 'Detalhes'
    end

    # Assert
    within('tr#current-price') do
      expect(page).not_to have_content 'R$ 165,00'
      expect(page).to have_content 'R$ 170,00'
      expect(page).to have_content 'teste@locaweb.com.br'
    end

    within("tr#old-price#{price1.id}") do
      expect(page).to have_content 'R$ 150,00'
      expect(page).to have_content 'teste@locaweb.com.br'
    end

    within("tr#old-price#{price2.id}") do
      expect(page).to have_content 'R$ 165,00'
      expect(page).to have_content 'teste@locaweb.com.br'
    end
  end
end
