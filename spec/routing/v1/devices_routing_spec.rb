require 'rails_helper'

RSpec.describe V1::DevicesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/reservoirs/1/devices').to route_to('v1/devices#index', :reservoir_id => '1')
    end

    it 'routes to #show' do
      expect(:get => '/devices/1').to route_to('v1/devices#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/reservoirs/1/devices').to route_to('v1/devices#create', :reservoir_id => '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/devices/1').to route_to('v1/devices#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/devices/1').to route_to('v1/devices#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/devices/1').to route_to('v1/devices#destroy', :id => '1')
    end
  end
end
