require 'rails_helper'

RSpec.describe V1::FlowSensorsDataController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/flow_sensors/1/flow_sensors_data').to route_to('v1/flow_sensors_data#index', :flow_sensor_id => '1')
    end

    it 'routes to #show' do
      expect(:get => '/flow_sensors_data/1').to route_to('v1/flow_sensors_data#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/flow_sensors/1/flow_sensors_data').to route_to('v1/flow_sensors_data#create', :flow_sensor_id => '1')
    end
  end
end
