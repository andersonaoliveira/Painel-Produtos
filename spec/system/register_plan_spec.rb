require 'rails_helper'

describe 'Usuário registra um plano' do
  context 'e usuário não logado' do
    it 'não vê link no menu' do
      # Act
      visit root_path

      # Assert
      expect(page).not_to have_link 'Cadastrar Plano'
    end

    it 'não acessa formulario diretamente' do
      # Act
      visit new_plan_path

      # Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'com sucesso' do
    # Arrange
    user = create(:user)
    create(:product_group, name: 'HOSP')
    create(:product_group, name: 'EMAIL')

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Plano'
    fill_in 'Nome', with: 'Hospedagem Básica'
    fill_in 'Descrição', with: '1 Site 250 GB de Armazenamento SSD 1 Conta de Email'
    fill_in 'Detalhes', with: '1 Site com 250 GB de armazenamento pertencente ao grupo HOSP'
    select 'HOSP', from: 'Grupo de produtos'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Hospedagem Básica'
    expect(page).to have_content 'Descrição'
    expect(page).to have_content '1 Site 250 GB de Armazenamento SSD 1 Conta de Email'
    expect(page).to have_content 'Detalhes'
    expect(page).to have_content '1 Site com 250 GB de armazenamento pertencente ao grupo HOSP'
    expect(page).to have_content 'HOSP'
    expect(page).not_to have_content 'EMAL'
  end

  it 'e os campos devem ser obrigatórios' do
    # Arrange
    user = create(:user, administrator: true)
    create(:product_group)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Plano'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Detalhes não pode ficar em branco'
    expect(page).to have_content 'Grupo de Produtos é obrigatório(a)'
  end

  it 'e consegue retornar atravez do botao' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Plano'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq plans_path
  end
end
