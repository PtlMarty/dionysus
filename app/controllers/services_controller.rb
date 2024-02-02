class ServicesController < ApplicationController
  def index
    @services = Service.all
    if params[:query].present?
      sql_subquery = <<~SQL
        services.name ILIKE :query
        OR services.description ILIKE :query
        OR users.first_name ILIKE :query
        OR users.last_name ILIKE :query
      SQL
      @services = @services.joins(:user).where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    # GET /services/:id
    @service = Service.find(params[:id])
    @booking = Booking.new
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  # def tag_index
  #   @services = Service.tagged_with(service_params[:tag_list], :any => true)
  # end

  def create
    @services = Service.all
    @service = Service.new(service_params)
      params[:service][:tag_list].each do |tag|
        @service.tag_list.add(tag) unless tag.empty?
      end
    if @service.save

      redirect_to services_path
    else
      render :index, status: :unprocessable_entity
    end
  end


  private

  def service_params
    params.require(:service).permit(:name, :description, :price_hours, :tag_list).merge(user_id: current_user.id)
  end
end
