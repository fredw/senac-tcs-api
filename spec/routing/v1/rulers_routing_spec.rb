require 'rails_helper'

RSpec.describe V1::RulersController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/devices/1/rulers').to route_to('v1/rulers#index', :device_id => '1')
    end

    it 'routes to #show' do
      expect(:get => '/rulers/1').to route_to('v1/rulers#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/devices/1/rulers').to route_to('v1/rulers#create', :device_id => '1')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/rulers/1').to route_to('v1/rulers#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/rulers/1').to route_to('v1/rulers#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/rulers/1').to route_to('v1/rulers#destroy', :id => '1')
    end
  end
end
