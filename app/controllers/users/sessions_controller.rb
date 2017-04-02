class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user

  def destroy
    skip_authorization
    render json: ['Signed out']
  end
end
