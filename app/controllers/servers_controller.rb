class ServersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_params, only: %i[create]
  before_action :find_id, only: %i[show]

  def index
    @servers = Server.all
  end

  def new
    @plans = Plan.all
    @server = Server.new
  end

  def show; end

  def create
    @plans = Plan.all
    @server = Server.new(@server_params)

    if @server.save
      redirect_to server_path(@server.id), notice: 'Servidor criado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar Servidor!'
      render 'new'
    end
  end

  private

  def set_params
    @server_params = params.require(:server).permit(:capacity, :plan_id)
  end

  def find_id
    @server = Server.friendly.find(params[:id])
  end
end
