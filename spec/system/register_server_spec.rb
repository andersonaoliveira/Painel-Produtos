require 'rails_helper'
describe 'Usuario cadastra um novo servidor' do
  context 'e usuário não logado' do
    it 'não vê link no menu' do
      # Act
      visit root_path

      # Assert
      expect(page).not_to have_link 'Cadastrar Servidor'
    end

    it 'não acessa formulario diretamente' do
      # Arrange

      # Act
      visit new_server_path

      # Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(page).to have_button 'Entrar'
    end
  end

  it 'Com sucesso' do
    # Arrange
    user = create(:user)
    allow(SecureRandom).to receive(:alphanumeric).with(16).and_return 'SRV-1111111111111111'
    pg = create(:product_group)
    create(:plan, product_group: pg, name: 'Email')

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Servidor'
    fill_in 'Capacidade', with: 100
    select 'Email', from: 'Plano'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'SRV-1111111111111111'
    expect(page).to have_content 'Capacidade 100'
    expect(page).to have_content 'Email'
  end

  it 'e os campos devem ser obrigatórios' do
    # Arrange
    user = create(:user, administrator: true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Servidor'
    fill_in 'Capacidade', with: ''
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Capacidade não pode ficar em branco'
    expect(page).to have_content 'Plano é obrigatório(a)'
  end
end
