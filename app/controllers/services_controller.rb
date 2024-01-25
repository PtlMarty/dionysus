class ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def show
    # GET /services/:id
    @service = Service.find(params[:id])
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to service_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price_hours)
  end
end
