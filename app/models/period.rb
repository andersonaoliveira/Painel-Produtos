class Period < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, :months, presence: true
  validates :name, :months, uniqueness: true
end
