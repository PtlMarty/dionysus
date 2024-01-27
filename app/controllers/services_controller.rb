class ServicesController < ApplicationController
  def index
    @services = Service.all
    @service = Service.new
  end

  def show
    # GET /services/:id
    @service = Service.find(params[:id])
    @booking = Booking.new
  end

  def new
  end

  def create
    @services = Service.all
    @service = Service.new(service_params)
    if @service.save

      redirect_to services_path
    else
      raise
      render :index, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price_hours).merge(user_id: current_user.id)
  end
end
