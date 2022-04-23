require 'rails_helper'

RSpec.describe Period, type: :model do
  describe 'Usuário tenta cadastrar período' do
    it 'e não preenche o campo meses' do
      # Arrange
      period = Period.create(name: 'Meses', months: '')

      # Act
      result = period.valid?

      # Assert
      expect(result).to eq false
    end

    it 'e não cadastra períodos duplicados' do
      # Arrange
      Period.create(name: 'Meses', months: '1')
      period = Period.create(name: 'Meses', months: '1')

      # Act
      result = period.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
