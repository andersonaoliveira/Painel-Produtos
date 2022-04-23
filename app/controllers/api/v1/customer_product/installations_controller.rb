class Api::V1::CustomerProduct::InstallationsController < Api::V1::ApiController
  def create
    product_params = params.permit(:plan_id, :customer, :product_code, :status)
    return render status: 422, json: { 'error:': 'Todos os parametros são obrigatórios' } if product_params.empty?

    @product = Product.create(product_params)

    if @product.persisted?
      render status: 201
    else
      render status: 422
    end
  end

  def inactive
    @product = Product.find_by(product_code: params[:id])

    return render status: 404, json: { 'error:': 'Objeto não encontrado' } if @product.nil?

    @product.inactive!
    render status: 201
  end
end
