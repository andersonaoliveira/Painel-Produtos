require 'rails_helper'

RSpec.describe Price, type: :model do
  it '.current_price' do
    # Arrange
    product_group = create(:product_group)
    period = create(:period)
    plan = create(:plan, product_group: product_group)
    create(:price, value: 160.0, plan: plan, period: period)
    current_price = create(:price, value: 170.0, plan: plan, period: period)

    # Act
    result = plan.current_price(period)

    # Assert
    expect(result).to eq current_price
  end

  it '.current_prices' do
    # Arrange
    product_group = create(:product_group)
    period = create(:period, name: 'Mensal', months: '1')
    period2 = create(:period, name: 'Semestral', months: '6')
    plan = create(:plan, product_group: product_group)
    create(:price, value: 160.0, plan: plan, period: period)
    create(:price, value: 170.0, plan: plan, period: period2)

    # Act
    result = plan.current_prices

    # Assert
    expect(result.length).to eq 2
    expect(result[0].value.to_i).to eq 160.0
    expect(result[1].value.to_i).to eq 170.0
  end

  it '.old_prices' do
    # Arrange
    product_group = create(:product_group)
    period = create(:period, name: 'Semestral', months: '6')
    plan = create(:plan, product_group: product_group)
    create(:price, value: 160.0, plan: plan, period: period)
    create(:price, value: 165.0, plan: plan, period: period)
    create(:price, value: 170.0, plan: plan, period: period)

    # Act
    result = plan.old_prices(period)

    # Assert
    expect(result.length).to eq 2
    expect(result[0].value.to_i).to eq 160
    expect(result[1].value.to_i).to eq 165
  end

  it 'preço não pode ser menor que zero' do
    # Arrange
    product_group = create(:product_group)
    period = create(:period)
    plan = create(:plan, product_group: product_group)
    pr = build(:price, value: 0.0, plan: plan, period: period)

    # Act
    result = pr.valid?

    # Assert
    expect(result).to eq false
  end

  context 'os campos não podem ficar em branco' do
    it 'preço' do
      # Arrange
      product_group = create(:product_group)
      period = create(:period)
      plan = create(:plan, product_group: product_group)
      pr = build(:price, value: '', plan: plan, period: period)

      # Act
      result = pr.valid?

      # Assert
      expect(result).to eq false
    end

    it 'plano' do
      # Arrange
      period = create(:period)
      pr = build(:price, value: 10.00, period: period)

      # Act
      result = pr.valid?

      # Assert
      expect(result).to eq false
    end

    it 'periodo' do
      # Arrange
      product_group = create(:product_group)
      plan = create(:plan, product_group: product_group)
      pr = build(:price, value: 10.00, plan: plan)

      # Act
      result = pr.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
