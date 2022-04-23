require 'rails_helper'

describe 'Periods API' do
  context 'GET/api/v1/periods' do
    it 'com sucesso' do
      # Arrange
      create(:period, name: 'Mensal')
      create(:period, name: 'Semestral', months: '6')

      # Act
      get '/api/v1/periods'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['id']).to eq 1
      expect(parsed_response[0]['name']).to eq 'Mensal'
      expect(parsed_response[1]['id']).to eq 2
      expect(parsed_response[1]['name']).to eq 'Semestral'
    end

    it 'retorna vazio' do
      # Act
      get '/api/v1/periods'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end
end
