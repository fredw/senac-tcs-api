module V1
  class DevicesSettingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_device, only: :generate

    # GET /devices/1/generate_settings
    def generate
      render json: @device,
             serializer: DeviceSettingsSerializer,
             include: [:flow_sensors, rulers: :level_sensors],
             adapter: :json,
             meta_key: :user,
             meta: { email: current_user.email, password: 'your-password' }
    end

    private

    def set_device
      @device = policy_scope(Device.find(params[:device_id]))
      authorize @device
    end
  end
end