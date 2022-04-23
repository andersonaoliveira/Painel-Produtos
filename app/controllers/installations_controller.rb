class InstallationsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    @installations = Product.all
  end
end
