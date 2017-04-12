class Users::PasswordsController < Devise::PasswordsController
  def create
    skip_authorization
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { success: 'Confirmation e-mail sent' }, status: :ok
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def update
    skip_authorization
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end
