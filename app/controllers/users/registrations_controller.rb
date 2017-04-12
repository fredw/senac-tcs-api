class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_params_create, only: [:create]
  before_action :configure_params_update, only: [:update]
  before_action :authenticate_user!

  def create
    if user_signed_in?
      authorize current_user
    else
      throw(:warden)
    end
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if user_signed_in?
      skip_authorization
    else
      throw(:warden)
    end
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      bypass_sign_in resource, scope: resource_name
      render json: resource
    else
      clean_up_passwords resource
      render json: resource.errors, status: :unprocessable_entity
    end
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
