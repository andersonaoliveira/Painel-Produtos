class ProductGroupsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_params, only: %i[create update]
  before_action :find_id, only: %i[show edit update]

  def index
    @product_groups = ProductGroup.all
  end

  def show; end

  def new
    @plan = Plan.all
    @product_group = ProductGroup.new
  end

  def create
    @product_group = ProductGroup.new(@product_group_params)

    if @product_group.save
      redirect_to product_group_path(@product_group.id), notice: 'Grupo de Produtos criado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar Grupo de Produtos!'
      render 'new'
    end
  end

  def edit; end

  def update
    if @product_group.update(@product_group_params)
      redirect_to product_group_path(@product_group.id), notice: 'Grupo de Produtos editado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível editar o Grupo de Produtos!'
      render 'edit'
    end
  end

  private

  def set_params
    @product_group_params = params.require(:product_group).permit(
      :name, :description, :icon, :key
    )
  end

  def find_id
    @product_group = ProductGroup.friendly.find(params[:id])
  end
end
