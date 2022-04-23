class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_unless_admin, only: %i[new create edit update]
  before_action :set_params, only: %i[create update]
  before_action :find_id, only: %i[show edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(@user_params)

    if @user.save
      redirect_to root_path, notice: 'Usuário cadastrado com sucesso.'
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    return redirect_to(user_path(@user.id)) if @user.update(@user_params)

    render :edit
  end

  private

  def redirect_unless_admin
    return if current_user.administrator?

    flash[:notice] = 'Somente administradores podem acessar esta página.'
    redirect_to root_path
  end

  def set_params
    @user_params = params.require(:user).permit(:email, :password, :password_confirmation, :administrator)
  end

  def find_id
    @user = User.find(params[:id])
  end
end
