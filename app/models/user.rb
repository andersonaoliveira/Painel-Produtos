class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :email, format: { with: /@locaweb\.com.br/, message: 'deve possuir o domínio de @locaweb.com.br' }
end
