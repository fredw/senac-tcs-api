module V1
  class ReservoirsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reservoir, only: [:show, :update, :destroy]

    has_scope :reservoir_group, only: :index
    has_scope :search, only: :index

    # GET /reservoirs
    def index
      @reservoirs = policy_scope(apply_scopes(Reservoir.order(:reservoir_group_id)))
      authorize Reservoir
      paginate json: @reservoirs, include: :reservoir_group
    end

    # GET /reservoirs/1
    def show
      render json: @reservoir
    end

    # POST /reservoirs
    def create
      @reservoir = Reservoir.new(reservoir_params)
      authorize @reservoir
      if @reservoir.save
        render json: @reservoir, status: :created, location: @reservoir
      else
        render json: @reservoir.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /reservoirs/1
    def update
      if @reservoir.update(reservoir_params)
        render json: @reservoir
      else
        render json: @reservoir.errors, status: :unprocessable_entity
      end
    end

    # DELETE /reservoirs/1
    def destroy
      @reservoir.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_reservoir
      @reservoir = Reservoir.find(params[:id])
      authorize @reservoir
    end

    # Only allow a trusted parameter "white list" through.
    def reservoir_params
      params.require(:reservoir).permit(:name, :description, :volume, :customer_id, :reservoir_group_id)
    end
  end
end