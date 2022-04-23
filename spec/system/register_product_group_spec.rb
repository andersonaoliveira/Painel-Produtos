require 'rails_helper'

describe 'Usuário registra grupo de produto' do
  context 'e usuário não logado' do
    it 'não vê link no menu' do
      # Act
      visit root_path

      # Assert
      expect(page).not_to have_link 'Cadastrar Grupo de Produtos'
    end

    it 'não acessa formulario diretamente' do
      # Arrange

      # Act
      visit new_product_group_path

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
    click_on 'Cadastrar Grupo de Produtos'
    fill_in 'Nome', with: 'Email'
    fill_in 'Descrição', with: 'Serviços de Email'
    attach_file 'Ícone', Rails.root.join('spec/support/icons/email.png')
    fill_in 'Chave', with: 'EMAIL'
    click_on 'Salvar'

    # Assert
    save_page
    expect(current_path).to eq product_group_path(ProductGroup.last.id)
    expect(page).to have_content 'Grupo de Produtos criado com sucesso!'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Descrição: Serviços de Email'
    expect(page).to have_css("img[src*='email.png']")
    expect(page).to have_content 'Chave: EMAIL'
  end

  it 'e todos os campos são obrigatórios' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Grupo de Produtos'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    # Assert
    expect(current_path).to eq product_groups_path
    expect(page).to have_content 'Não foi possível cadastrar Grupo de Produtos!'
    expect(page).not_to have_content 'Grupo de Produtos criado com sucesso!'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Ícone não pode ficar em branco'
    expect(page).to have_content 'Chave não pode ficar em branco'
  end

  it 'e chave deve estar no formato correto' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Grupo de Produtos'
    fill_in 'Nome', with: 'Email'
    fill_in 'Descrição', with: 'Serviços de Email'
    attach_file 'Ícone', Rails.root.join('spec/support/icons/email.png')
    fill_in 'Chave', with: 'EMAIL6'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Chave deve ser uma sequência de até 5 letras'
  end

  context 'e campo tem que ser único' do
    it 'nome' do
      # Arrange
      create(:product_group, name: 'Email')
      user = create(:user)

      # Act
      login_as(user)
      visit root_path
      click_on 'Cadastrar Grupo de Produtos'
      fill_in 'Nome', with: 'Email'
      click_on 'Salvar'

      # Assert
      expect(page).to have_content 'Nome já está em uso'
    end

    it 'chave' do
      # Arrange
      create(:product_group, key: 'EMAIL')
      user = create(:user)

      # Act
      login_as(user)
      visit root_path
      click_on 'Cadastrar Grupo de Produtos'
      fill_in 'Chave', with: 'EMAIL'
      click_on 'Salvar'

      # Assert
      expect(page).to have_content 'Chave já está em uso'
    end
  end

  it 'e consegue retornar atravez do botao' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Grupo de Produtos'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq product_groups_path
  end
end
