class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_params_create, only: [:create]
  before_action :configure_params_update, only: [:update]

  def create
    authorize User
    super
  end

  def update
    super
  end

  protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_params_create
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :customer_id, :role_id])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_params_update
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
    end
end
