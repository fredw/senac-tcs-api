module V1
  class FlowSensorsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_flow_sensor, only: [:show, :update, :destroy]

    # GET /flow_sensors
    def index
      @flow_sensors = policy_scope(FlowSensor.where(device_id: params[:device_id]))
      authorize FlowSensor
      paginate json: @flow_sensors
    end

    # GET /flow_sensors/1
    def show
      render json: @flow_sensor
    end

    # POST /flow_sensors
    def create
      @flow_sensor = FlowSensor.new(flow_sensor_params)
      authorize @flow_sensor
      if @flow_sensor.save
        render json: @flow_sensor, status: :created, location: @flow_sensor
      else
        render json: @flow_sensor.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /flow_sensors/1
    def update
      if @flow_sensor.update(flow_sensor_params)
        render json: @flow_sensor
      else
        render json: @flow_sensor.errors, status: :unprocessable_entity
      end
    end

    # DELETE /flow_sensors/1
    def destroy
      @flow_sensor.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_flow_sensor
      @flow_sensor = policy_scope(FlowSensor.find(params[:id]))
      authorize @flow_sensor
    end

    # Only allow a trusted parameter "white list" through.
    def flow_sensor_params
      params.require(:flow_sensor).permit(:pin, :device_id)
    end
  end
end