class HomeController < ApplicationController
  def index
    @plans = Plan.where(status: :available)
    @product_groups = ProductGroup.all
  end
end
