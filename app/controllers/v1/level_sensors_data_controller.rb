module V1
  class LevelSensorsDataController < ApplicationController
    before_action :authenticate_user!
    before_action :set_level_sensor_data, only: [:show, :update, :destroy]

    has_scope :by_date, :using => [:from, :to], only: :index
    has_scope :switched_on, type: :boolean, allow_blank: true, only: :index

    # GET /level_sensors_data
    def index
      @level_sensors_data = policy_scope(apply_scopes(LevelSensorData.where(level_sensor_id: params[:level_sensor_id]).order(created_at: :desc)))
      authorize LevelSensorData
      paginate json: @level_sensors_data
    end

    # GET /level_sensors_data/1
    def show
      render json: @level_sensor_data
    end

    # POST /level_sensors_data
    def create
      @level_sensor_data = LevelSensorData.new(level_sensor_data_params)
      authorize @level_sensor_data
      if @level_sensor_data.save
        render json: @level_sensor_data, status: :created, location: @level_sensor_data
      else
        render json: @level_sensor_data.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /level_sensors_data/1
    def update
      if @level_sensor_data.update(level_sensor_data_params)
        render json: @level_sensor_data
      else
        render json: @level_sensor_data.errors, status: :unprocessable_entity
      end
    end

    # DELETE /level_sensors_data/1
    def destroy
      @level_sensor_data.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_level_sensor_data
      @level_sensor_data = LevelSensorData.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def level_sensor_data_params
      params.require(:level_sensor_data).permit(:level_sensor_id, :switched_on)
    end
  end
end