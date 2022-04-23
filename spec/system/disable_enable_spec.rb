require 'rails_helper'

describe 'Usuario é capaz de mudar status' do
  it 'desativando um plano com sucesso' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, name: 'Email Basico', product_group: pg)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Desativar Plano'

    # Assert
    expect(page).to have_content 'Plano desativado com sucesso'
    expect(page).not_to have_content 'Email Basico'
  end

  it 'ativando um plano com sucesso' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, name: 'Email Basico', status: 1, product_group: pg)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    click_on 'Planos Desativados'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Ativar Plano'

    # Assert
    expect(page).to have_content 'Plano ativado com sucesso'
    expect(page).to have_content 'Email Basico'
  end

  it 'erro na desativação' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, name: 'Hospedagem básica', product_group: pg)
    allow_any_instance_of(Plan).to receive(:update).and_return(false)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Desativar Plano'

    # Assert
    expect(current_path).to eq plan_path(pl.slug)
    expect(page).to have_content 'Não foi possível desativar o plano'
  end

  it 'erro na ativação' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, name: 'Hospedagem básica', status: 1, product_group: pg)
    allow_any_instance_of(Plan).to receive(:update).and_return(false)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    click_on 'Planos Desativados'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Ativar Plano'

    # Assert
    expect(current_path).to eq "#{plan_path(pl.slug)}/active"
    expect(page).to have_content 'Não foi possível ativar o plano'
  end
end
