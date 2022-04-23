require 'rails_helper'

describe 'Usuário vê todos os grupos de produtos' do
  it 'e vê os grupos de produtos registrado' do
    # Arrange
    pg1 = create(
      :product_group,
      name: 'Cloud',
      key: 'EMLS'
    )
    pg2 = create(
      :product_group,
      name: 'Email',
      key: 'EML'
    )
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Grupos de Produtos'

    # Assert
    within("tr#group-#{pg1.id}") do
      expect(page).to have_link 'Detalhes'
      expect(page).to have_content 'Cloud'
      expect(page).to have_content 'EMLS'
    end
    within("tr#group-#{pg2.id}") do
      expect(page).to have_link 'Detalhes'
      expect(page).to have_content 'Email'
      expect(page).to have_content 'EML'
    end
  end

  it 'e nao vê os detalhes do grupo de produtos' do
    # Arrange
    pg1 = create(
      :product_group,
      name: 'Cloud',
      key: 'EMLS'
    )
    pg2 = create(
      :product_group,
      name: 'Email',
      key: 'EML'
    )
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Grupos de Produtos'

    # Assert
    within("tr#group-#{pg1.id}") do
      expect(page).to have_content 'Cloud'
      expect(page).to have_content 'EMLS'
      expect(page).not_to have_css("img[src*='cloud.png']")
    end
    within("tr#group-#{pg2.id}") do
      expect(page).to have_content 'Email'
      expect(page).to have_content 'EML'
      expect(page).not_to have_css("img[src*='email.png']")
    end
  end

  it 'e visualiza um grupo de produtos específico' do
    # Arrange
    user = create(:user)
    pg = create(
      :product_group,
      name: 'Email',
      description: 'Serviços de Email', key: 'EML'
    )

    # Act
    login_as(user)
    visit product_groups_path
    within("tr#group-#{pg.id}") do
      click_on 'Detalhes'
    end

    # Assert
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Descrição: Serviços de Email'
    expect(page).to have_content 'Chave: EML'
    expect(page).to have_css("img[src*='email.png']")
  end

  it 'e não existem grupos de produtos' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Grupos de Produtos'

    # Assert
    expect(page).to have_content 'Nenhum grupo de produtos cadastrado'
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
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq product_groups_path
  end
end
