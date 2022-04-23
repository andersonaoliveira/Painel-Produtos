require 'rails_helper'

describe 'Usuário registra um periodo' do
  context 'e usuário não logado' do
    it 'não vê link no menu' do
      # Act
      visit root_path

      # Assert
      expect(page).not_to have_link 'Cadastrar Periodicidade'
    end

    it 'não acessa formulario diretamente' do
      # Act
      visit new_period_path

      # Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'com sucesso' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Periodicidade'
    fill_in 'Nome', with: 'Mensal'
    fill_in 'Meses', with: '1'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Período cadastrado com sucesso.'
    expect(page).to have_content 'Nome do Período: Mensal'
    expect(page).to have_content 'Quantidade de Meses: 1'
  end

  it 'e os campos devem ser obrigatórios' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Periodicidade'
    fill_in 'Nome', with: ''
    fill_in 'Meses', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Não foi possível salvar a periodicidade.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Meses não pode ficar em branco'
  end

  it 'e consegue retornar atravez do botao' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Periodicidade'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq periods_path
  end
end
