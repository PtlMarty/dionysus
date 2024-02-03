class BookingsController < ApplicationController
  # as a user i can see all booking request from other users
  def index
    @bookings = current_user.bookings
    @my_bookings_as_provider = current_user.bookings_as_provider
  end

  # display new booking
  def new
    @booking = Booking.new
    @service = Service.find(params[:service_id])
    @user = current_user.id
    @booking.service = @service
  end

  # create a new booking

  def create
    @booking = Booking.new(booking_params)
    @service = Service.find(params[:service_id])
    @booking.service = @service
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end


# accept or reject the booking by clicking on a button
  def accept
    @booking = Booking.find(params[:id])
    if @booking.update(status: 'accepted')
      redirect_to @booking, notice: 'Booking was accepted.'
    else
      render :show, alert: 'Failed to accept booking.', status: :unprocessable_entity
    end
  end

  def rejected
    @booking = Booking.find(params[:id])
    if @booking.update(status: 'rejected')
      redirect_to @booking, notice: 'Booking was rejected.'
    else
      render :show, alert: 'Failed to reject booking.', status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date, :service_id, :comment).merge(user_id: current_user.id, status: "pending")
  end
end
