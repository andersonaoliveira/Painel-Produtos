require 'rails_helper'

describe 'Product Group API' do
  context 'GET /api/v1/product_groups' do
    it 'com sucesso' do
      # Arrange
      create(:product_group, name: 'Email', key: 'EMAIL')
      create(:product_group, name: 'Cloud', key: 'CLOUD')

      # Act
      get '/api/v1/product_groups'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['id']).to eq 1
      expect(parsed_response[0]['name']).to eq 'Email'
      expect(parsed_response[1]['name']).to eq 'Cloud'
      expect(parsed_response[0]['key']).to eq 'EMAIL'
      expect(parsed_response[1]['key']).to eq 'CLOUD'
      expect(parsed_response[0]['icon']).to include 'email.png'
      expect(parsed_response[1]['icon']).to include 'cloud.png'
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
    end

    it 'retorna vazio' do
      # Arrange

      # Act
      get '/api/v1/product_groups'

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_groups/:id' do
    it 'com sucesso' do
      # Arrange
      pg = create(
        :product_group,
        name: 'Email', key: 'EMAIL', description: 'Serviços de email'
      )

      # Act
      get "/api/v1/product_groups/#{pg.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to eq 'Email'
      expect(parsed_response['key']).to eq 'EMAIL'
      expect(parsed_response['description']).to eq 'Serviços de email'
      expect(parsed_response['icon']).to include 'email.png'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'e grupo de produto não existe' do
      # Act
      get '/api/v1/product_groups/999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error:']).to eq 'Objeto não encontrado'
    end
  end

  it 'banco de dados erro - 500' do
    # Arrange
    pg = create(:product_group)
    allow(ProductGroup).to receive(:find).with(pg.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
    # Act
    get("/api/v1/product_groups/#{pg.id}")

    # Assert
    expect(response.status).to eq 500
    parsed_response = JSON.parse(response.body)
    expect(parsed_response['error:']).to eq 'Não foi possível conectar ao banco de dados'
  end
end
