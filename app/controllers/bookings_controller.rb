class BookingsController < ApplicationController

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
