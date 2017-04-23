require 'rails_helper'

RSpec.describe V1::FlowSensorsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/devices/1/flow_sensors').to route_to('v1/flow_sensors#index', :device_id => '1')
    end

    it 'routes to #show' do
      expect(:get => '/flow_sensors/1').to route_to('v1/flow_sensors#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/devices/1/flow_sensors').to route_to('v1/flow_sensors#create', :device_id => '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/flow_sensors/1').to route_to('v1/flow_sensors#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/flow_sensors/1').to route_to('v1/flow_sensors#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/flow_sensors/1').to route_to('v1/flow_sensors#destroy', :id => '1')
    end
  end
end
