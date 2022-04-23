require 'rails_helper'

describe 'Product API' do
  context 'POST /api/v1/customer_product/installations' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group)
      pl = create(:plan, product_group: pg)
      allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
      create(:server, capacity: 10, plan: pl)

      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = { customer: '11451231547', plan_id: pl.id, product_code: '1521484789' }
      post '/api/v1/customer_product/installations', params: params, headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to be_a_kind_of(Integer)
      expect(parsed_response['customer']).to eq '11451231547'
      expect(parsed_response['plan_id']).to eq pl.id
      expect(parsed_response['server_code']).to eq 'SRV-1111111111111111'
      expect(parsed_response['status']).to eq 'active'
      expect(parsed_response['product_code']).to eq '1521484789'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'e campos são obrigatórios' do
      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = {}
      post '/api/v1/customer_product/installations', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Todos os parametros são obrigatórios'
    end

    it 'e CPF está no formato errado' do
      # Arrange
      pg = create(:product_group)
      pl = create(:plan, product_group: pg)
      allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
      create(:server, capacity: 10, plan: pl)

      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = { customer: '114512315470', plan_id: pl.id }
      post '/api/v1/customer_product/installations', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Cliente não é válido'
    end
  end

  context 'PATCH /api/v1/customer_product/installations/:product_code/inactive' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group)
      pl = create(:plan, product_group: pg)
      allow(SecureRandom).to receive(:alphanumeric).with(16).and_return '1111111111111111'
      create(:server, capacity: 10, plan: pl)
      pr = create(:product, customer: '45187984524', product_code: '1521484789', plan: pl)

      # Act
      headers = { 'Content-Type ' => 'application/json' }
      patch "/api/v1/customer_product/installations/#{pr.product_code}/inactive", headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to be_a_kind_of(Integer)
      expect(parsed_response['customer']).to eq '45187984524'
      expect(parsed_response['product_code']).to eq '1521484789'
      expect(parsed_response['server_code']).to eq 'SRV-1111111111111111'
      expect(parsed_response['status']).to eq 'inactive'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'produto não existe' do
      # Act
      patch '/api/v1/customer_product/installations/1234567890/inactive'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error:']).to eq 'Objeto não encontrado'
    end
  end
end
