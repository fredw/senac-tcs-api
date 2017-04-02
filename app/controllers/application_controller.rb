class ApplicationController < ActionController::API

  include Pundit
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index
  before_action :check_customer_active

  respond_to :json
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::ActiveRecordError, with: :active_record_error

  protected

    # Check authorization for all requests
    def check_customer_active
      authorize :app if user_signed_in?
    end

    # Pundit - NotAuthorizedError
    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s
      message = 'Unauthorized route!'
      message = 'Customer unauthorized! Please, contact the administrators' if policy_name == 'AppPolicy'
      render_exception(message, :unauthorized)
    end

    # Active record error
    def active_record_error(exception)
      render_exception(exception.message, :not_found)
    end

    # Render exception
    def render_exception(message, status)
      render :json => {error: message}, :status => status
    end
end
