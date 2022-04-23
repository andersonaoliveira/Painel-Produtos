class Product < ApplicationRecord
  belongs_to :plan
  belongs_to :server
  validates :customer, format: { with: /(^\d{11}$)/ }

  before_validation :greater_capacity, on: :create
  validate :no_server_available

  enum status: {
    active: 0,
    inactive: 1
  }

  private

  def greater_capacity
    server = plan.servers.first
    plan.servers.each do |s|
      server = s if s.server_availability > server.server_availability
    end
    self.server_id = server.id
  end

  def no_server_available
    errors.add(:product, true) if server.total_installations == server.capacity
  end
end
