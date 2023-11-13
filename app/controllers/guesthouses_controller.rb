class GuesthousesController < ApplicationController
  before_action :set_guesthouse, only: [:show, :edit, :update]
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def show
    @rooms = @guesthouse.rooms
  end

  def new
    if current_user.guesthouse.present?
      redirect_to root_path, notice: 'Você já cadastrou uma pousada.'
    else
      @guesthouse = Guesthouse.new
      @guesthouse.build_address
    end
  end

  def create
    @guesthouse = current_user.build_guesthouse(guesthouse_params)
    if @guesthouse.save
      return redirect_to @guesthouse, notice: 'Pousada cadastrada com sucesso.'
    end
    flash.now[:notice] = 'Pousada não cadastrada.'
    render 'new', status: 422
  end

  def edit; end

  def update
    if @guesthouse.update(guesthouse_params)
      return redirect_to @guesthouse, notice: 'Pousada atualizada com sucesso.'
    end
    flash.now[:notice] = 'Não foi possível atualizar a pousada.'
    render 'edit', status: 422
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
    payment_method: [],
    address_attributes: [:id, :street, :neighborhood, :city, :state, :postal_code]
  )
  end

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:id])
  end

  def authenticate_owner!
    if user_signed_in? && current_user.owner?
    else
      redirect_to new_user_session_path, alert: 'Acesso negado' unless user_signed_in?
    end
  end

  def authorize_user!
    unless @guesthouse.user_id == current_user.id
      redirect_to root_path
    end
  end
end