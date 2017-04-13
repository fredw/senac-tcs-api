class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user

  def destroy
    skip_authorization
    if user_signed_in?
      current_user.save
      render json: { success: 'Signed out' }, status: :ok
    else
      throw(:warden)
    end
  end

  def respond_with(resource, _opts = {})
    render json: resource
  end
end
