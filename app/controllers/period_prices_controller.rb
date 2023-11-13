class PeriodPricesController < ApplicationController
  before_action :set_room
  before_action :authenticate_owner!
  before_action :set_period_price, only: [:edit, :update, :destroy]

  def new
    @period_price = @room.period_prices.new
  end

  def create
    @period_price = @room.period_prices.new(period_price_params)
    if @period_price.save
      redirect_to [@guesthouse, @room], notice: 'Preço por período cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @period_price.update(period_price_params)
      redirect_to [@guesthouse, @room], notice: 'Preço por período atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @period_price.destroy
    redirect_to [@guesthouse, @room], notice: 'Preço por período removido com sucesso.'
  end

  private

  def set_room
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    @room = @guesthouse.rooms.find(params[:room_id])
  end

  def set_period_price
    @period_price = @room.period_prices.find(params[:id])
  end

  def period_price_params
    params.require(:period_price).permit(:start_date, :end_date, :daily_rate)
  end

  def authenticate_owner!
    redirect_to new_user_session_path, alert: 'Acesso negado' unless user_signed_in? && current_user.owner?
  end
end