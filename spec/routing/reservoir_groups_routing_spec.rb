require 'rails_helper'

RSpec.describe ReservoirGroupsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/reservoir_groups').to route_to('reservoir_groups#index')
    end

    it 'routes to #show' do
      expect(:get => '/reservoir_groups/1').to route_to('reservoir_groups#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/reservoir_groups').to route_to('reservoir_groups#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/reservoir_groups/1').to route_to('reservoir_groups#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/reservoir_groups/1').to route_to('reservoir_groups#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/reservoir_groups/1').to route_to('reservoir_groups#destroy', :id => '1')
    end
  end
end
