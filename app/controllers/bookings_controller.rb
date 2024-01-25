class BookingsController < ApplicationController
  # as a user i can see all booking request from other users
  def index
    @bookings = current_user.bookings
    @my_bookings_as_provider = current_user.bookings_as_provider
  end

# accept or reject the booking by clicking on a button
  def accept
    @booking = Booking.find(params[:id])
    @booking.status = "accepted"
    @booking.save
    redirect_to bookings_path
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.status = "rejected"
    @booking.save
    redirect_to bookings_path
  end
  private

  def booking_params
    params.require(:booking).permit(:status)
  end
end
