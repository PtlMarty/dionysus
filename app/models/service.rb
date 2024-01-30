class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :price_hours, presence: true
  acts_as_taggable_on :tags
  acts_as_taggable_on :country, :color
end
