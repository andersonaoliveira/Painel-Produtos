require 'rails_helper'

describe 'Administrador acessa o sistema' do
  it 'e o visualiza usuários' do
    # Arrange
    user = create(:user, administrator: true)
    user2 = create(:user, email: 'mktdeprodutos@locaweb.com.br', administrator: false)
    user3 = create(:user, email: 'teste2@locaweb.com.br', administrator: true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Usuários'

    # Assert
    within("tr#user-#{user2.id}") do
      expect(page).to have_content 'mktdeprodutos@locaweb.com.br'
    end

    within("tr#user-#{user3.id}") do
      expect(page).to have_content 'teste2@locaweb.com.br'
    end
  end

  it 'e visualiza informações de um usuário' do
    # Arrange
    user = create(:user, administrator: true)
    user2 = create(:user, email: 'mktdeprodutos@locaweb.com.br', administrator: false)

    # Act
    login_as(user)
    visit root_path
    click_on 'Usuários'
    within("tr#user-#{user2.id}") do
      click_on 'Detalhes'
    end

    # Assert
    expect(page).to have_content 'mktdeprodutos@locaweb.com.br'
    expect(page).to have_content "Criado em: #{I18n.l user2.created_at, format: :short}"
    expect(page).to have_content "Última alteração: #{I18n.l user2.updated_at, format: :short}"
  end

  it 'acessa a página de um usuário específico e consegue voltar para a listagem de usuários' do
    # Arrange
    user = create(:user, email: 'teste@locaweb.com.br', administrator: true)
    user2 = create(:user, email: 'mktdeprodutos@locaweb.com.br', administrator: false)

    # Act
    login_as(user)
    visit root_path
    click_on 'Usuários'
    within("tr#user-#{user2.id}") do
      click_on 'Detalhes'
    end
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq users_path
    expect(page).to have_content 'teste@locaweb.com.br'
    expect(page).to have_content 'mktdeprodutos@locaweb.com.br'
  end

  it 'e um usuário cadastrado que não é administrador não consegue visualizar os usuários' do
    # Arrange
    user = create(:user, email: 'mktdeprodutos@locaweb.com.br', administrator: false)

    # Act
    login_as(user)
    visit root_path

    # Assert
    expect(page).not_to have_content 'Usuários'
  end
end
