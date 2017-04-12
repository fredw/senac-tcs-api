class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    skip_authorization
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    if resource.errors.empty?
      render json: { success: 'User confirmed' }, status: :ok
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end
