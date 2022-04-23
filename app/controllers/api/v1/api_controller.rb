class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :internal_server_error

  private

  def not_found
    render status: 404, json: { 'error:': 'Objeto não encontrado' }
  end

  def internal_server_error
    render status: 500, json: { 'error:': 'Não foi possível conectar ao banco de dados' }
  end
end
