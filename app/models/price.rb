class Price < ApplicationRecord
  belongs_to :period
  belongs_to :plan
  validates :value, presence: true
  validates :value, numericality: { greater_than: 0 }
end
