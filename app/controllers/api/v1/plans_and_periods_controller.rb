class Api::V1::PlansAndPeriodsController < Api::V1::ApiController
  def index
    @plans = Plan.where(status: :available)
  end

  def show
    plan = Plan.find(params[:id])
    if plan.available?
      @plan = plan
    else
      render status: 410, json: { 'error:': 'O acesso ao recurso não está mais disponível' }
    end
  end
end
