class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_owners_to_new_guesthouse

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def redirect_owners_to_new_guesthouse
    return unless user_signed_in? && current_user.owner? && !current_user.guesthouse.present?

    unless request.path == new_guesthouse_path || request.path == destroy_user_session_path
      flash[:alert] = 'Por favor, cadastre sua pousada'
      redirect_to new_guesthouse_path
    end
  end
end
