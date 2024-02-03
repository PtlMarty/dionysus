class ServicesController < ApplicationController
  def index
    @services = Service.all
    if params[:mine].present?
      # this is linked to the nav bar's link to services_path :mine
      @services = @services.for_user(current_user.id)
    else
      # this is the default view - services shown will be not the current user's
      @services = @services.without_user(current_user.id)
    end
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

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @services = Service.all
    @service = Service.find(params[:id])
    if @service.update(service_params)
      redirect_to services_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price_hours, :tag_list).merge(user_id: current_user.id)
  end
end
