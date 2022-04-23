class Server < ApplicationRecord
  extend FriendlyId
  friendly_id :code, use: :slugged
  has_many :products, dependent: :destroy
  belongs_to :plan
  before_create :generate_code
  validates :capacity, presence: true
  validates :capacity, numericality: { greater_than: 0, message: 'deve ser maior que 0' }

  def total_installations
    products.count
  end

  def server_availability
    capacity - total_installations
  end

  private

  def generate_code
    self.code = "SRV-#{SecureRandom.alphanumeric(16)}"
  end
end
