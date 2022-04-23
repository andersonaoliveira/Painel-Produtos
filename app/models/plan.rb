class Plan < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :products, dependent: :destroy
  has_many :prices, dependent: :restrict_with_exception
  has_many :servers, dependent: :destroy
  belongs_to :product_group
  validates :name, :description, :details, :status, presence: true

  enum status: {
    available: 0,
    unavailable: 1
  }

  def current_prices
    periods = Period.all
    results = []
    periods.each do |period|
      results << prices.where(period: period).last
    end
    results.delete_if(&:blank?)
    results
  end

  def current_price(period)
    prices.where(period: period).last
  end

  def old_prices(period)
    all_prices = prices.where(period: period)
    current_price = current_price(period)
    old_prices = []
    all_prices.each do |p|
      old_prices << p if p != current_price
    end
    old_prices
  end
end
