module V1
  class FlowSensorsDataController < ApplicationController
    before_action :authenticate_user!
    before_action :set_flow_sensor_data, only: [:show, :update, :destroy]

    has_scope :by_date, :using => [:from, :to], only: :index

    # GET /flow_sensors_data
    def index
      @flow_sensors_data = policy_scope(apply_scopes(FlowSensorData.where(flow_sensor_id: params[:flow_sensor_id]).order(created_at: :desc)))
      authorize FlowSensorData
      paginate json: @flow_sensors_data
    end

    # GET /flow_sensors_data/1
    def show
      render json: @flow_sensor_data
    end

    # POST /flow_sensors_data
    def create
      @flow_sensor_data = FlowSensorData.new(flow_sensor_data_params)
      authorize @flow_sensor_data
      if @flow_sensor_data.save
        render json: @flow_sensor_data, status: :created, location: @flow_sensor_data
      else
        render json: @flow_sensor_data.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /flow_sensors_data/1
    def update
      if @flow_sensor_data.update(flow_sensor_data_params)
        render json: @flow_sensor_data
      else
        render json: @flow_sensor_data.errors, status: :unprocessable_entity
      end
    end

    # DELETE /flow_sensors_data/1
    def destroy
      @flow_sensor_data.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_flow_sensor_data
      @flow_sensor_data = FlowSensorData.find(params[:id])
      authorize @flow_sensor_data
    end

    # Only allow a trusted parameter "white list" through.
    def flow_sensor_data_params
      params.require(:flow_sensor_data).permit(:consumption_per_minute, :flow_sensor_id)
    end
  end
end
