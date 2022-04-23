require 'rails_helper'

describe 'Administrador edita usuário' do
  it 'com sucesso' do
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
    click_on 'Editar Usuário'
    fill_in 'E-mail', with: 'marketingprodutos@locaweb.com.br'
    fill_in 'Senha', with: '12345678'
    check 'Administrador'
    click_on 'Alterar'

    # Assert
    expect(page).to have_content 'marketingprodutos@locaweb.com.br'
    expect(page).to have_content "Criado em: #{I18n.l user2.created_at, format: :short}"
    expect(page).to have_content "Última alteração: #{I18n.l user2.updated_at, format: :short}"
  end

  it 'e não preenche a senha' do
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
    click_on 'Editar Usuário'
    fill_in 'E-mail', with: 'marketingprodutos@locaweb.com.br'
    check 'Administrador'
    click_on 'Alterar'

    # Assert
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
end
