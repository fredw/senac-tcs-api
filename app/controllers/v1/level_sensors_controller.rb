module V1
  class LevelSensorsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_level_sensor, only: [:show, :update, :destroy]

    # GET /level_sensors
    def index
      @level_sensors = policy_scope(LevelSensor.where(ruler_id: params[:ruler_id]))
      authorize LevelSensor
      paginate json: @level_sensors
    end

    # GET /level_sensors/1
    def show
      render json: @level_sensor
    end

    # POST /level_sensors
    def create
      @level_sensor = LevelSensor.new(level_sensor_params)
      authorize @level_sensor
      if @level_sensor.save
        render json: @level_sensor, status: :created, location: @level_sensor
      else
        render json: @level_sensor.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /level_sensors/1
    def update
      if @level_sensor.update(level_sensor_params)
        render json: @level_sensor
      else
        render json: @level_sensor.errors, status: :unprocessable_entity
      end
    end

    # DELETE /level_sensors/1
    def destroy
      @level_sensor.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_level_sensor
        @level_sensor = LevelSensor.find(params[:id])
        authorize @level_sensor
      end

      # Only allow a trusted parameter "white list" through.
      def level_sensor_params
        params.require(:level_sensor).permit(:pin, :volume, :sequence, :ruler_id)
      end
  end
end