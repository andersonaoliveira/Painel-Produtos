require 'rails_helper'

RSpec.describe Server, type: :model do
  describe 'Contabiliza os produtos instalados' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group)
      plan = create(:plan, product_group: pg)
      sv = create(:server, capacity: 100, plan: plan)
      create(:product, plan: plan, product_code: 'QYJKQMGKR9', customer: '12345678900')
      create(:product, plan: plan, product_code: 'YYYYQMGKR9', customer: '12345678900')

      # Act
      result = sv.total_installations

      # Assert
      expect(result).to eq 2
    end
  end
end
