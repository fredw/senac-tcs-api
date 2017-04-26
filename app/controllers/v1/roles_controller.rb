module V1
  class RolesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show]

    # GET /roles
    def index
      @roles = policy_scope(Role)
      authorize Role
      paginate json: @roles
    end

    # GET /roles/1
    def show
      render json: @role
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @role = Role.find(params[:id])
      authorize @role
    end
  end
end
