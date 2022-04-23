class Api::V1::ProductGroupsController < Api::V1::ApiController
  def index
    @product_groups = ProductGroup.all
  end

  def show
    @product_group = ProductGroup.find(params[:id])
  end
end
