require 'rails_helper'

RSpec.describe V1::LevelSensorsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/rulers/1/level_sensors').to route_to('v1/level_sensors#index', :ruler_id => '1')
    end

    it 'routes to #show' do
      expect(:get => '/level_sensors/1').to route_to('v1/level_sensors#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/rulers/1/level_sensors').to route_to('v1/level_sensors#create', :ruler_id => '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/level_sensors/1').to route_to('v1/level_sensors#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/level_sensors/1').to route_to('v1/level_sensors#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/level_sensors/1').to route_to('v1/level_sensors#destroy', :id => '1')
    end
  end
end
