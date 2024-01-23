class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :name, presence: true
  validates :description, presence: true
  validates :price_hours, presence: true
end