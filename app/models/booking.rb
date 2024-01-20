class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :user
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :comment, presence: true
  validates :status, presence: true
  enum status: { pending: 0, accepted: 1, rejected: 2}


end
