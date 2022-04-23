class ProductGroup < ApplicationRecord
  has_one_attached :icon
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :plans, dependent: :destroy
  validates :name, :description, :icon, :key, presence: true
  validates :name, :key, uniqueness: true
  validates :key, format: { with: /\A[A-Za-z]{1,5}\z/, message: 'deve ser uma sequência de até 5 letras' }
end
