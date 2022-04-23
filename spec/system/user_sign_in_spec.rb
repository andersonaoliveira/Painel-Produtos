require 'rails_helper'

describe 'Usuário efetua login' do
  it 'e não consegue acessar página de cadastro de usuário se não é um administrador' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Cadastrar usuário'
  end

  it 'e não consegue acessar a página de cadastro através da URL' do
    # Act
    visit create_user_path

    # Assert
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(page).to have_button 'Entrar'
  end

  it 'e não consegue acessar a página de cadastro através da URL se não for um administrador' do
    # Arrange
    user = create(:user, administrator: false)

    # Act
    login_as(user)
    visit create_user_path

    # Assert
    expect(page).to have_content 'Somente administradores podem acessar esta página.'
  end

  it 'e o administrador efetua um cadastro para o usuário conseguir realizar o login' do
    # Arrange
    user = create(:user, administrator: true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar usuário'
    fill_in 'E-mail', with: 'teste2@locaweb.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Cadastrar'
    click_on 'Sair'
    fill_in 'E-mail', with: 'teste2@locaweb.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    # Assert
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    expect(page).to have_content 'Olá, teste2@locaweb.com.br'
  end

  it 'e o administrador efetua um cadastro para o usuário e não preenche um dos campos' do
    # Arrange
    user = create(:user, administrator: true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar usuário'
    fill_in 'E-mail', with: 'teste2@locaweb.com.br'
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(current_path).to eq create_user_path
  end

  it 'e preenche email sem domínio locaweb' do
    # Arrange
    user = create(:user, administrator: true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar usuário'
    fill_in 'E-mail', with: 'teste2@teste.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content 'E-mail deve possuir o domínio de @locaweb.com.br'
  end

  it 'e o administrador efetua um cadastro de um outro administrador' do
    # Arrange
    user = create(:user, administrator: true)

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar usuário'

    fill_in 'E-mail', with: 'teste2@locaweb.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    check 'Administrador'
    click_on 'Cadastrar'
    click_on 'Sair'
    fill_in 'E-mail', with: 'teste2@locaweb.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    # Assert
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    expect(page).to have_content 'Olá, teste2@locaweb.com.br'
    expect(page).to have_content 'Administrador'
  end

  it 'com sucesso' do
    # Arrange
    create(:user)

    # Act
    visit root_path
    fill_in 'E-mail', with: 'teste@locaweb.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    expect(page).to have_content 'Olá, teste@locaweb.com.br'
  end

  it 'e efetua logout' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Sair'

    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_content 'Olá, teste@locaweb.com.br'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Senha'
  end
end
