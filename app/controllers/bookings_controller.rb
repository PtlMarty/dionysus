class BookingsController < ApplicationController

  def index
    @bookings = current_user.bookings
  end


  def new
    @booking = Booking.new
  end

  # def create
  #   @booking = Booking.new(booking_params)
  #   if @booking.save
  #     flash[:success] = "Booking created"
  #     redirect_to @booking
  #   else
  #     flash.now[:error] = "Booking not created"
  #     render 'new'
  #   end
  # end

  def show
    @bookings = Booking.find(params[:id])
  end


  private

    def booking_params
      params.require(:booking).permit(:id)
    end


end
