require 'rails_helper'

describe 'Usuario é capaz de editar informações sobre um plano' do
  context 'e usuário não logado' do
    it 'não vê link no menu' do
      # Arrange
      pg = create(:product_group)
      create(:plan, product_group: pg)

      # Act
      visit root_path

      # Assert
      expect(page).not_to have_link 'Planos'
    end

    it 'nao acessa o formulario diretamente' do
      # Arrange
      pg = create(:product_group)
      pl = create(:plan, product_group: pg)

      # Act
      visit edit_plan_path(pl.id)

      # Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'atravez da tela de listagem' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, product_group: pg)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'

    # Assert
    expect(current_path).to eq edit_plan_path(pl.slug)
    expect(page).to have_content 'Editar Plano'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Detalhes'
  end

  it 'com sucesso' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    create(:plan, product_group: pg)
    pl = create(:plan, product_group: pg)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Nome', with: 'Hospedagem padrão'
    fill_in 'Descrição', with: '1 Site 250 GB de Armazenamento SSD 1 Conta de Email'
    fill_in 'Detalhes', with: '1 Site com 250 GB de armazenamento pertencente ao grupo HOSP'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Plano atualizado com sucesso'
    expect(page).to have_content 'Hospedagem padrão'
    expect(page).to have_content '1 Site 250 GB de Armazenamento SSD 1 Conta de Email'
    expect(page).to have_content '1 Site com 250 GB de armazenamento pertencente ao grupo HOSP'
  end

  it 'deixando os campos em branco' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, product_group: pg)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Detalhes', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Detalhes não pode ficar em branco'
  end

  it 'e consegue retornar atravez do botao' do
    # Arrange
    user = create(:user)
    pg = create(:product_group)
    pl = create(:plan, product_group: pg)

    # Act
    login_as(user)
    visit root_path
    click_on 'Planos'
    within("tr#plan-#{pl.id}") do
      click_on 'Detalhes'
    end
    click_on 'Editar'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq plans_path
  end
end
