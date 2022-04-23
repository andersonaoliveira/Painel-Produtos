require 'rails_helper'

RSpec.describe ProductGroup, type: :model do
  context 'os campos não podem ser vazio' do
    it 'nome' do
      # Arrange
      pg = build(:product_group, name: '')

      # Act
      result = pg.valid?

      # Assert
      expect(result).to eq false
    end

    it 'descrição' do
      # Arrange
      pg = build(:product_group, description: '')

      # Act
      result = pg.valid?

      # Assert
      expect(result).to eq false
    end

    it 'chave' do
      # Arrange
      pg = build(:product_group, key: '')

      # Act
      result = pg.valid?

      # Assert
      expect(result).to eq false
    end
  end

  context 'chave esta no formato errado' do
    it 'EMAILS' do
      # Arrange
      pg = build(:product_group, key: 'EMAILS')

      # Act
      result = pg.valid?

      # Assert
      expect(result).to eq false
    end

    it 'EMAI1' do
      # Arrange
      pg = build(:product_group, key: 'EMAI1')

      # Act
      result = pg.valid?

      # Assert
      expect(result).to eq false
    end
  end

  context 'campo tem que ser único' do
    it 'nome' do
      # Arrange
      create(:product_group, name: 'EMAIL')
      pg = build(:product_group, name: 'EMAIL')

      # Act
      result = pg.valid?

      # Assert
      expect(result).to eq false
    end

    it 'chave' do
      # Arrange
      create(:product_group, key: 'EMAIL')
      pg = build(:product_group, key: 'EMAIL')

      # Act
      result = pg.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
