class Api::V1::PeriodsController < Api::V1::ApiController
  def index
    @periods = Period.all
  end
end
