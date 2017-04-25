require 'rails_helper'

RSpec.describe V1::DevicesSettingsController, type: :routing do
  describe 'routing' do

    it 'routes to #generate' do
      expect(:get => '/devices/1/generate_settings').to route_to('v1/devices_settings#generate', :device_id => '1')
    end
  end
end
