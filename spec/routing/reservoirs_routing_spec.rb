require "rails_helper"

RSpec.describe ReservoirsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/reservoirs").to route_to("reservoirs#index")
    end

    it "routes to #new" do
      expect(:get => "/reservoirs/new").to route_to("reservoirs#new")
    end

    it "routes to #show" do
      expect(:get => "/reservoirs/1").to route_to("reservoirs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reservoirs/1/edit").to route_to("reservoirs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/reservoirs").to route_to("reservoirs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reservoirs/1").to route_to("reservoirs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reservoirs/1").to route_to("reservoirs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reservoirs/1").to route_to("reservoirs#destroy", :id => "1")
    end

  end
end
