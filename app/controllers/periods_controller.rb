class PeriodsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create edit]
  before_action :set_params, only: %i[create update]
  before_action :find_id, only: %i[show edit update]

  def index
    @periods = Period.all
  end

  def new
    @period = Period.new
  end

  def create
    @period = Period.new(@period_params)

    if @period.save
      redirect_to @period, notice: 'Período cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível salvar a periodicidade.'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @period.update(@period_params)
      redirect_to period_path(@period.id), notice: 'Periodo editado com sucesso!'
    else
      flash.now[:danger] = 'Não foi possível atualizar o periodo'
      render 'edit'
    end
  end

  private

  def set_params
    @period_params = params.require(:period).permit(:name, :months)
  end

  def find_id
    @period = Period.friendly.find(params[:id])
  end
end
