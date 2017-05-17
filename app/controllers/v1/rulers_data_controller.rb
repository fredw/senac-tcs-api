module V1
  class RulersDataController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ruler_data, only: [:show]

    has_scope :by_date, :using => [:from, :to], only: :index
    has_scope :last_record, only: :last

    # GET /ruler_data
    def index
      @rulers_data = policy_scope(apply_scopes(RulerData.where(ruler_id: params[:ruler_id]))).order(created_at: :asc)
      authorize RulerData
      paginate json: @rulers_data,
               include: %w(ruler, level_sensor_data, level_sensor_data.level_sensor),
               root: :data,
               adapter: :json
    end

    # GET /ruler_data_last
    def last
      @ruler_data = RulerData.where(ruler_id: params[:ruler_id]).order(created_at: :desc).limit(1)
      authorize RulerData
      render json: policy_scope(apply_scopes(@ruler_data)).first || {},
             include: %w(ruler, level_sensor_data, level_sensor_data.level_sensor),
             root: :data,
             adapter: :json
    end

    # GET /ruler_data/1
    def show
      render json: @ruler_data,
             include: %w(ruler, level_sensor_data, level_sensor_data.level_sensor),
             root: :data,
             adapter: :json
    end

    # POST /ruler_data
    def create
      @ruler_data = RulerData.new(ruler_data_params)
      authorize @ruler_data
      if @ruler_data.save
        render json: @ruler_data, status: :created, location: @ruler_data
      else
        render json: @ruler_data.errors, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_ruler_data
      @ruler_data = RulerData.find(params[:id])
      authorize @ruler_data
    end

    # Only allow a trusted parameter "white list" through.
    def ruler_data_params
      params.require(:ruler_data).permit(:ruler_id, level_sensor_data_attributes: [:level_sensor_id, :switched_on])
    end
  end
end
