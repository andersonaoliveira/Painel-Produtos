require 'rails_helper'

RSpec.describe Plan, type: :model do
  context 'os campos não podem ficar em branco' do
    it 'nome' do
      # Arrange
      product_group = create(:product_group)
      plan = build(:plan, name: '', product_group: product_group)

      # Act
      result = plan.valid?

      # Assert
      expect(result).to eq false
    end

    it 'descrição' do
      # Arrange
      product_group = create(:product_group)
      plan = build(:plan, description: '', product_group: product_group)

      # Act
      result = plan.valid?

      # Assert
      expect(result).to eq false
    end

    it 'detalhes' do
      # Arrange
      product_group = create(:product_group)
      plan = build(:plan, details: '', product_group: product_group)

      # Act
      result = plan.valid?

      # Assert
      expect(result).to eq false
    end

    it 'status' do
      # Arrange
      product_group = create(:product_group)
      plan = build(:plan, status: '', product_group: product_group)

      # Act
      result = plan.valid?

      # Assert
      expect(result).to eq false
    end

    it 'grupo de produtos' do
      # Arrange
      plan = build(:plan)

      # Act
      result = plan.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
