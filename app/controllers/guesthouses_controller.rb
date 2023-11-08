class GuesthousesController < ApplicationController
  before_action :guesthouse_params, only: [:create]
  before_action :set_guesthouse, only: [:show]

  def show; end

  def new
    @guesthouse = Guesthouse.new
    @guesthouse.build_address
  end

  def create
    @guesthouse = Guesthouse.new(guesthouse_params)
    if @guesthouse.save
      return redirect_to @guesthouse, notice: 'Pousada cadastrada com sucesso.'
    end
    flash.now[:notice] = 'Pousada não cadastrada.'
    render 'new', status: 422
  end

  private
  def guesthouse_params
    params.require(:guesthouse).permit(
    :brand_name,
    :corporate_name,
    :registration_number, 
    :phone_number,
    :email,
    :description,
    :pets,
    :use_policy,
    :checkin,
    :checkout,
    :status,
    address_attributes: [:id, :street, :neighborhood, :city, :state, :postal_code]
  )
  end

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:id])
  end
end