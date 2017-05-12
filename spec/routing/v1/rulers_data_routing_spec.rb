require 'rails_helper'

RSpec.describe V1::RulersDataController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/rulers/1/rulers_data').to route_to('v1/rulers_data#index', :ruler_id => '1')
    end

    it 'routes to #show' do
      expect(:get => '/rulers_data/1').to route_to('v1/rulers_data#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/rulers/1/rulers_data').to route_to('v1/rulers_data#create', :ruler_id => '1')
    end
  end
end
