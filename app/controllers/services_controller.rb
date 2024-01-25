class ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def show
    # GET /services/:id
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price_hours)
  end


end
