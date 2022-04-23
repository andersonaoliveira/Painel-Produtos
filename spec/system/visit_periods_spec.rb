require 'rails_helper'

describe 'Usuário vê todos os períodos' do
  it 'com sucesso' do
    # Arrange
    user = create(:user)
    pr1 = create(:period, name: 'Mensal', months: 1)
    pr2 = create(:period, name: 'Semestral', months: 6)

    # Act
    login_as(user)
    visit root_path
    click_on 'Periodicidades'

    # Assert
    within("tr#period-#{pr1.id}") do
      expect(page).to have_link 'Detalhes'
      expect(page).to have_content 'Mensal'
      expect(page).to have_content '1'
    end
    within("tr#period-#{pr2.id}") do
      expect(page).to have_link 'Detalhes'
      expect(page).to have_content 'Semestral'
      expect(page).to have_content '6'
    end
  end

  it 'e visualiza um período específico' do
    # Arrange
    user = create(:user)
    pr = create(:period, name: 'Mensal', months: '1')

    # Act
    login_as(user)
    visit root_path
    click_on 'Periodicidades'
    within("tr#period-#{pr.id}") do
      click_on 'Detalhes'
    end

    # Assert
    expect(page).to have_content 'Nome do Período: Mensal'
    expect(page).to have_content 'Quantidade de Meses: 1'
  end

  it 'e não existem períodos' do
    # Arrange
    user = create(:user)

    # Act
    login_as(user)
    visit root_path
    click_on 'Periodicidades'

    # Assert
    expect(page).to have_content 'Nenhum período cadastrado'
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
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq periods_path
  end
end
