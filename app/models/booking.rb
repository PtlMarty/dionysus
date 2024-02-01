class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :comment, presence: true
  validates :status, presence: true
  enum status: { pending: 0, accepted: 1, rejected: 2}, _default: :pending
<<<<<<< HEAD
=======

  def pending?
    status == 'pending'
  end
>>>>>>> master
end
