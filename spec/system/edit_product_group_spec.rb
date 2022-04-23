require 'rails_helper'

describe 'Usuário edita um grupo de produtos' do
  context 'e usuário não logado' do
    it 'não vê link no menu' do
      # Arrange
      create(:product_group)

      # Act
      visit root_path

      # Assert
      expect(page).not_to have_link 'Grupos de Produtos'
    end

    it 'nao acessa o formulario diretamente' do
      # Arrange
      pg = create(:product_group)

      # Act
      visit edit_product_group_path(pg.id)

      # Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'atravez da tela de listagem' do
    # Arrange
    user = create(:user)
    pg = create(:product_group, name: 'Cloud', key: 'CLOUD')

    # Act
    login_as(user)
    visit root_path
    click_on 'Grupos de Produtos'
    within("tr#group-#{pg.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'

    # Assert
    expect(current_path).to eq edit_product_group_path(pg.slug)
    expect(page).to have_content 'Editar Grupo de Produtos'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Chave'
    expect(page).to have_field 'Ícone'
    expect(page).to have_field 'Descrição'
  end

  it 'com sucesso' do
    # Arrange
    user = create(:user)
    create(:product_group, name: 'E-commerce', key: 'ECOMM')
    create(:product_group, name: 'Cloud', key: 'CLOUD')
    pg3 = create(:product_group, name: 'Teste', key: 'TESTE')

    # Act
    login_as(user)
    visit root_path
    click_on 'Grupos de Produtos'
    within("tr#group-#{pg3.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Nome',	with: 'Email'
    click_on 'Salvar'

    # Assert
    expect(current_path).to eq product_group_path(pg3.id)
    expect(page).to have_content 'Grupo de Produtos editado com sucesso'
    expect(page).to have_content 'Email'
  end

  it 'e nao consegue editar' do
    # Arrange
    user = create(:user)
    create(:product_group, name: 'Cloud', key: 'CLOUD')
    pg = create(:product_group, name: 'Email', key: 'EMAIL')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Grupos de Produtos'
    within("tr#group-#{pg.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Nome',	with: 'Cloud'
    click_on 'Salvar'

    # Assert
    expect(page).not_to have_content 'Grupo de Produtos editado com sucesso'
    expect(page).to have_content 'Não foi possível editar o Grupo de Produtos!'
    expect(page).to have_content 'Nome já está em uso'
  end

  it 'e consegue retornar atravez do botao' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)

    # Act
    login_as(user)
    visit root_path
    click_on 'Grupos de Produtos'
    within("tr#group-#{pg.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq product_groups_path
  end
end
