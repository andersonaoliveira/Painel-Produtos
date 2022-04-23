require 'rails_helper'

describe 'Plan API' do
  context 'GET /api/v1/plans' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group, name: 'Email', key: 'EMAIL')
      create(:plan, name: 'Email Basico', details: 'teste', product_group: pg)
      create(:plan, name: 'Email Avançado', details: 'testando detalhes', product_group: pg)

      # Act
      get '/api/v1/plans'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['name']).to include 'Email Basico'
      expect(parsed_response[0]['details']).to include 'teste'
      expect(parsed_response[0]['product_group']['name']).to include 'Email'
      expect(parsed_response[0]['product_group']['key']).to include 'EMAIL'
      expect(parsed_response[0]['product_group'].keys).not_to include 'icon'
      expect(parsed_response[0]['product_group'].keys).not_to include 'description'
      expect(parsed_response[0]['product_group'].keys).not_to include 'created_at'
      expect(parsed_response[0]['product_group'].keys).not_to include 'updated_at'
      expect(parsed_response[1]['name']).to include 'Email Avançado'
      expect(parsed_response[1]['details']).to include 'testando detalhes'
    end

    it 'não mostra planos desativados' do
      # Arrange
      pg = create(:product_group, name: 'Email')
      create(:plan, name: 'Email Basico', details: 'teste', product_group: pg)
      create(:plan, name: 'Email Premiun', details: 'testando', status: :unavailable, product_group: pg)

      # Assert
      get '/api/v1/plans'

      # Act
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['name']).to include 'Email Basico'
      expect(parsed_response[0]['details']).to include 'teste'
      expect(parsed_response[0]['product_group']['name']).to include 'Email'
      expect(parsed_response).not_to include 'Email Premiun'
      expect(parsed_response).not_to include 'testando'
    end

    it 'retorna vazio' do
      # Act
      get '/api/v1/plans'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/plans/:id' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group, name: 'Email', key: 'EMAIL')
      pl = create(:plan, name: 'Email Basico', details: 'teste', product_group: pg)
      create(:plan, name: 'Email Avançado', product_group: pg)

      # Act
      get "/api/v1/plans/#{pl.id}"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to include 'Email Basico'
      expect(parsed_response['details']).to include 'teste'
      expect(parsed_response['product_group']['name']).to include 'Email'
      expect(parsed_response['product_group']['key']).to include 'EMAIL'
      expect(parsed_response['status']).to include 'available'
      expect(parsed_response['name']).not_to include 'Email Avançado'
    end

    it 'plano nao existe' do
      # Act
      get '/api/v1/plans/999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error:']).to eq 'Objeto não encontrado'
    end
  end
end
