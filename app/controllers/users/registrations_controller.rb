class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  # def after_sign_up_path_for(resources)
  #   if resource.owner?
  #     new_guesthouse_path
  #   else
  #     super
  #   end
  # end
end
