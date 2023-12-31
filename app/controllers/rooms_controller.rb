class RoomsController < ApplicationController
  before_action :set_guesthouse
  before_action :authenticate_owner!
  before_action :set_room, only: [:show, :edit, :update]

  def index
    @available_rooms = @guesthouse.rooms.where(status: true)
  end
  
  def show; end
  
  def new
    @room = @guesthouse.rooms.new
  end

  def create
    @room = @guesthouse.rooms.new(room_params)
    if @room.save
      return redirect_to [@guesthouse, @room], notice: 'Quarto cadastrado com sucesso.'
    end
      flash.now[:notice] = 'Não foi possível cadastrar o quarto.'
      render 'new', status: 422
  end

  def edit; end

  def update
    if @room.update(room_params)
      return redirect_to @guesthouse, notice: 'Quarto atualizado com sucesso.'
    end
    flash.now[:notice] = 'Não foi possível atualizar o quarto'
    render 'edit', status: 422
  end

  def manage_period_prices
    @period_prices = @room.period_prices.order(:start_date)
  end

  private
  def room_params
    params.require(:room).permit(:name, :description, :size, :max_capacity, :daily_rate, 
                                 :bathroom, :balcony, :air_conditioning, :tv, :closet,
                                 :safe, :accessibility, :status)
  end

  def set_guesthouse
    @guesthouse = current_user.guesthouse
  end

  def authenticate_owner!
    if user_signed_in? && current_user.owner?
    else
      redirect_to new_user_session_path, alert: 'Acesso negado' unless user_signed_in?
    end
  end

  def set_room
    @room = @guesthouse.rooms.find(params[:id])
  end
end