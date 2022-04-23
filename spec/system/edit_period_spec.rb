require 'rails_helper'

describe 'Usuario edita um período' do
  context 'e usuário não logado' do
    it 'não vê link no menu' do
      # Arrange
      create(:period)

      # Act
      visit root_path

      # Assert
      expect(page).not_to have_link 'Periodicidades'
    end

    it 'nao acessa o formulario diretamente' do
      # Arrange
      period = create(:period)

      # Act
      visit edit_period_path(period.id)

      # Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'atravez da tela de listagem' do
    # Arrange
    user = create(:user)
    pr = create(:period)

    # Act
    login_as(user)
    visit root_path
    click_on 'Periodicidades'
    within("tr#period-#{pr.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'

    # Assert
    expect(current_path).to eq edit_period_path(pr.slug)
    expect(page).to have_content 'Editar período'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Meses'
  end

  it 'com sucesso' do
    # Arrange
    user = create(:user)
    create(:period, name: 'Trimestral')
    pr = create(:period, name: 'Mês')

    # Act
    login_as(user)
    visit root_path
    click_on 'Periodicidades'
    within("tr#period-#{pr.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Nome', with: 'Mensal'
    click_on 'Salvar'

    # Assert
    expect(page).to_not have_content 'Mês'
    expect(page).to have_content 'Mensal'
  end

  it 'e campo fica em branco' do
    # Arrange
    user = create(:user)
    pr = create(:period, name: 'Mês')

    # Act
    login_as(user)
    visit root_path
    click_on 'Periodicidades'
    within("tr#period-#{pr.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Meses', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Meses não pode ficar em branco'
  end

  it 'e consegue retornar atravez do botao' do
    # Arrange
    user = create(:user)
    pr = create(:period)

    # Act
    login_as(user)
    visit root_path
    click_on 'Periodicidades'
    within("tr#period-#{pr.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq periods_path
  end
end
