require 'rails_helper'

RSpec.describe V1::LevelSensorsDataController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/level_sensors/1/level_sensors_data').to route_to('v1/level_sensors_data#index', :level_sensor_id => '1')
    end

    it 'routes to #show' do
      expect(:get => '/level_sensors_data/1').to route_to('v1/level_sensors_data#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/level_sensors/1/level_sensors_data').to route_to('v1/level_sensors_data#create', :level_sensor_id => '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/level_sensors_data/1').to route_to('v1/level_sensors_data#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/level_sensors_data/1').to route_to('v1/level_sensors_data#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/level_sensors_data/1').to route_to('v1/level_sensors_data#destroy', :id => '1')
    end
  end
end
