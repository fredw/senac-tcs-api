class ApplicationController < ActionController::API

  include Pundit
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_customer_active

  respond_to :json
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::ActiveRecordError, with: :active_record_error

  protected

    # Devise - Allow user params on sign up and update
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :customer_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :customer_id])
    end

    # Check authorization for all requests
    def check_customer_active
      authorize :app
    end

    # Pundit - NotAuthorizedError
    def user_not_authorized
      render_exception('Unauthorized! Please contact the administrators', :unauthorized)
    end

    # Active record error
    def active_record_error(exception)
      render_exception(exception.message, :not_found)
    end

    # Render exception
    def render_exception(message, status)
      render :json => {error: message}, :status => status
    end

    # Devise overrided methods only to prevent IDE error
    def current_user
      super
    end
    def authenticate_user!
      super
    end
    def devise_controller?
      super
    end
end
