class Api::V1::PlansController < Api::V1::ApiController
  before_action :find_id, only: %i[show prices]

  def index
    @plans = Plan.available
  end

  def show; end

  def prices
    @prices = @plan.current_prices
  end

  private

  def find_id
    @plan = Plan.find(params[:id])
  end
end
