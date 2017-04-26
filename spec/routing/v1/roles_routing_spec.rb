require 'rails_helper'

RSpec.describe V1::RolesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/roles').to route_to('v1/roles#index')
    end

    it 'routes to #show' do
      expect(:get => '/roles/1').to route_to('v1/roles#show', :id => '1')
    end
  end
end
