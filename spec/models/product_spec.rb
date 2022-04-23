require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Instala no servidor disponível' do
    it 'e só existe um servidor com capacidade de instalação' do
      # Arrage
      pg = create(:product_group)
      plan = create(:plan, product_group: pg)
      create(:server, capacity: 100, plan: plan)
      pr = build(:product, plan: plan, product_code: 'YYYYQMGKR9', customer: '12345678900')

      # Act
      result = pr.save

      # Assert
      expect(result).to eq true
    end

    it 'existem dois servidores e ele tem capacidade igual de instalação' do
      # Arrage
      pg = create(:product_group)
      plan = create(:plan, product_group: pg)
      allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
      create(:server, capacity: 100, plan: plan)
      allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '2222222222222222'
      create(:server, capacity: 100, plan: plan)
      pr = build(:product, plan: plan, product_code: 'YYYYQMGKR9', customer: '12345678900')

      # Act
      result = pr.save

      # Assert
      expect(result).to eq true
      expect(pr.server_id).to eq 1
      expect(pr.server.code).to eq 'SRV-1111111111111111'
    end

    it 'existem dois servidores e um deles tem capacidade maior de instalação' do
      # Arrage
      pg = create(:product_group)
      plan = create(:plan, product_group: pg)
      allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
      create(:server, capacity: 99, plan: plan)
      allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '2222222222222222'
      create(:server, capacity: 100, plan: plan)
      pr = build(:product, plan: plan, product_code: 'YYYYQMGKR9', customer: '12345678900')

      # Act
      result = pr.save

      # Assert
      expect(result).to eq true
      expect(pr.server_id).to eq 2
      expect(pr.server.code).to eq 'SRV-2222222222222222'
    end

    it 'os dois servidores estão cheios' do
      # Arrage
      pg = create(:product_group)
      plan = create(:plan, product_group: pg)
      create(:server, capacity: 1, plan: plan)
      create(:server, capacity: 1, plan: plan)
      create(:product, plan: plan, product_code: '123YQMGKR9', customer: '12345678923')
      create(:product, plan: plan, product_code: '321YQMGKR9', customer: '12345670000')
      pr = build(:product, plan: plan, product_code: 'XYZKQMGKR9', customer: '67895678900')

      # Act
      result = pr.save

      # Assert
      expect(result).to eq false
    end
  end
end
