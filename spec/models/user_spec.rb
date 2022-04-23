require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Usuário não pode ser cadastrado' do
    it 'pois o email não é do domínio @locaweb.com.br' do
      # Arrange
      user = User.create(email: 'teste@teste.com.br', password: '12345678')

      # Act
      result = user.valid?

      # Assert
      expect(result).to eq false
    end

    it 'pois o senha esta em branco' do
      # Arrange
      user = User.create(email: 'teste@locaweb.com.br', password: '')

      # Act
      result = user.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
