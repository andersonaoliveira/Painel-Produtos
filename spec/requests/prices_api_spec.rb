require 'rails_helper'

describe 'price API' do
  context 'GET /api/v1/plans/:id/prices' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group)
      pl = create(:plan, name: 'Email Básico', product_group: pg)
      monthly = create(:period, name: 'Mensal', months: 1)
      yearly = create(:period, name: 'Anual', months: 12)
      create(:price, period: monthly, plan: pl, value: '15.00')
      create(:price, period: yearly, plan: pl, value: '10.00')

      # Act
      get "/api/v1/plans/#{pl.id}/prices"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['value']).to include '15.0'
      expect(parsed_response[0]['period']).to include 'Mensal'
      expect(parsed_response[1]['value']).to include '10.0'
      expect(parsed_response[1]['period']).to include 'Anual'
    end

    it 'retorna somente preço mais recente' do
      # Arrange
      pg = create(:product_group)
      pl = create(:plan, name: 'Email Básico', product_group: pg)
      monthly = create(:period, name: 'Mensal', months: 1)
      yearly = create(:period, name: 'Anual', months: 12)
      create(:price, period: monthly, plan: pl, value: '15.00')
      create(:price, period: monthly, plan: pl, value: '30.00')
      create(:price, period: yearly, plan: pl, value: '10.00')
      create(:price, period: yearly, plan: pl, value: '20.00')

      # Act
      get "/api/v1/plans/#{pl.id}/prices"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['value']).to include '30.0'
      expect(parsed_response[0]['value']).not_to include '15.0'
      expect(parsed_response[0]['period']).to include 'Mensal'
      expect(parsed_response[1]['value']).to include '20.0'
      expect(parsed_response[1]['value']).not_to include '10.0'
      expect(parsed_response[1]['period']).to include 'Anual'
    end

    it 'retorna vazio' do
      # Arrange
      pg = create(:product_group)
      pl = create(:plan, name: 'Email Básico', product_group: pg)

      # Act
      get "/api/v1/plans/#{pl.id}/prices"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end
end
