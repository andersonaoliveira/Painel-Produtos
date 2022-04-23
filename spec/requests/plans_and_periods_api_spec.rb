require 'rails_helper'

describe 'Plans and Periods API' do
  context 'GET/api/v1/plans_and_periods' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group)
      p1 = create(:period, name: 'Mensal', months: '1')
      p2 = create(:period, name: 'Semestral', months: '6')
      pl = create(:plan, name: 'Email Basico', product_group_id: pg.id)
      create(:price, plan: pl, period: p1)
      create(:price, plan: pl, period: p2)

      # Act
      get '/api/v1/plans_and_periods'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['id']).to eq 1
      expect(parsed_response[0]['name']).to include 'Email Basico'
      expect(parsed_response[0]['periods'][0]['period']).to include 'Mensal'
      expect(parsed_response[0]['periods'][1]['period']).to include 'Semestral'
    end
    it 'Não retorna planos inativos' do
      # Arrange
      pg = create(:product_group)
      p1 = create(:period, name: 'Mensal', months: '1')
      p2 = create(:period, name: 'Semestral', months: '6')
      pl = create(:plan, name: 'Email Basico', product_group: pg)
      pl2 = create(:plan, name: 'Email Avançado', product_group: pg)
      create(:price, plan: pl, period: p1)
      create(:price, plan: pl, period: p2)
      create(:price, plan: pl2, period: p1)

      # Act
      pl.unavailable!
      get '/api/v1/plans_and_periods'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['id']).to eq 2
      expect(parsed_response[0]['name']).to include 'Email Avançado'
      expect(parsed_response[0]['periods'][0]['period']).to include 'Mensal'
    end
  end
  context 'GET/api/v1/plans_and_periods/:id' do
    it 'com sucesso' do
      # Arrange
      pg = create(:product_group)
      p1 = create(:period, name: 'Mensal', months: '1')
      p2 = create(:period, name: 'Semestral', months: '6')
      pl = create(:plan, name: 'Email Basico', product_group: pg)
      pl2 = create(:plan, name: 'Email Avançado', product_group: pg)
      create(:price, plan: pl, period: p1)
      create(:price, plan: pl, period: p2)
      create(:price, plan: pl2, period: p1)

      # Act
      get "/api/v1/plans_and_periods/#{pl.id}"

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq 1
      expect(parsed_response['name']).to include 'Email Basico'
      expect(parsed_response['periods'][0]['period']).to include 'Mensal'
      expect(parsed_response['periods'][1]['period']).to include 'Semestral'
    end
    it 'não reconhece id de um plano que foi inativo' do
      # Arrange
      pg = create(:product_group)
      p1 = create(:period, name: 'Mensal', months: '1')
      p2 = create(:period, name: 'Semestral', months: '6')
      pl = create(:plan, name: 'Email Basico', product_group: pg)
      create(:price, plan: pl, period: p1)
      create(:price, plan: pl, period: p2)

      # Act
      pl.unavailable!
      get "/api/v1/plans_and_periods/#{pl.id}"

      # Assert
      expect(response).to have_http_status(410)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error:']).to eq 'O acesso ao recurso não está mais disponível'
    end
    it 'Retorna vazio' do
      # Act
      get '/api/v1/plans_and_periods'
      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
    it 'Plano nao existe' do
      # Act
      get '/api/v1/plans_and_periods/999'
      # Assert
      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error:']).to eq 'Objeto não encontrado'
    end
  end
end
