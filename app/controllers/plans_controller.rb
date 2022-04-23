class PlansController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit]
  before_action :set_params, only: %i[create update]
  before_action :find_id, only: %i[show edit update destroy active]
  before_action :find_plan_and_period, only: %i[new_price]
  before_action :find_all, only: %i[show new_price]

  def show
    @current_prices = @plan.current_prices
  end

  def new_price
    value = params[:value].gsub('.', '').sub(',', '.').to_f
    @new_price = Price.new(plan: @plan, period: @period, value: value, registered_by: current_user.email)
    if @new_price.save
      redirect_to @plan, success: 'Preço cadastrado com sucesso.'
    else
      @prices = @plan.current_prices
      render :show
    end
  end

  def index
    @plans = Plan.where(status: :available)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(@plan_params)
    if @plan.save
      redirect_to plan_path(@plan.id), success: 'Plano registrado com sucesso!'
    else
      flash.now[:danger] = 'Não foi possível gravar o plano'
      render 'new'
    end
  end

  def edit; end

  def update
    if @plan.update(@plan_params)
      redirect_to plan_path(@plan.id), success: 'Plano atualizado com sucesso '
    else
      flash.now[:danger] = 'Não foi possível atualizar o plano'
      render 'edit'
    end
  end

  def destroy
    if @plan.update(status: :unavailable)
      redirect_to plans_path, success: 'Plano desativado com sucesso'
    else
      flash.now[:danger] = 'Não foi possível desativar o plano'
      render 'edit'
    end
  end

  def disables
    @plans = Plan.where(status: :unavailable)
  end

  def active
    if @plan.update(status: :available)
      redirect_to plans_path, success: 'Plano ativado com sucesso'
    else
      flash.now[:danger] = 'Não foi possível ativar o plano'
      render 'edit'
    end
  end

  private

  def set_params
    @plan_params = params.require(:plan).permit(:name, :description, :details, :product_group_id)
  end

  def find_id
    @plan = Plan.friendly.find(params[:id])
  end

  def find_plan_and_period
    @plan = Plan.find(params[:plan_id])
    @period = Period.find(params[:period_id])
  end

  def find_all
    @periods = Period.all
  end
end
