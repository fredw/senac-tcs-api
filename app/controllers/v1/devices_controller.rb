module V1
  class DevicesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_device, only: [:show, :update, :destroy]

    # GET /devices
    def index
      @devices = policy_scope(Device.where(reservoir_id: params[:reservoir_id]))
      authorize Device
      paginate json: @devices
    end

    # GET /devices/1
    def show
      render json: @device
    end

    # POST /devices
    def create
      @device = Device.new(device_params)
      authorize @device
      if @device.save
        render json: @device, status: :created, location: @device
      else
        render json: @device.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /devices/1
    def update
      if @device.update(device_params)
        render json: @device
      else
        render json: @device.errors, status: :unprocessable_entity
      end
    end

    # DELETE /devices/1
    def destroy
      @device.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_device
        @device = Device.find(params[:id])
        authorize @device
      end

      # Only allow a trusted parameter "white list" through.
      def device_params
        params.require(:device).permit(:name, :description, :reservoir_id)
      end
  end
end