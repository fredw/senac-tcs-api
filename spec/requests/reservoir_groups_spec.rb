require 'rails_helper'

RSpec.describe "ReservoirGroups", type: :request do
  describe "GET /reservoir_groups" do
    it "works! (now write some real specs)" do
      get reservoir_groups_path
      expect(response).to have_http_status(200)
    end
  end
end
