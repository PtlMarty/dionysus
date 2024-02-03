class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many  :services
  has_many  :bookings
  has_many  :bookings_as_provider, through: :services, source: :bookings
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  has_one_attached :picture

  def avatar_picture
    # if photo.attached?
    #   picture
    # else
      "https://avatars.githubusercontent.com/u/77490521?v=4"
    # end
  end
end
