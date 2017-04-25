require 'rails_helper'

RSpec.describe 'DeviceSettings', type: :request do

  let(:device) { create(:device) }
  let(:device_id) { device.id }
  let(:user_admin) { create(:user_admin) }
  let(:headers_admin) { {'Authorization': sign_in(user_admin), 'Content-Type': 'application/json'} }

  describe 'GET /devices/:id/generate_settings' do

    context 'when the record exists' do
      let!(:flow_sensors) { create_list(:flow_sensor, 3, device_id: device.id) }
      let!(:rulers) { create_list(:ruler, 5, device_id: device.id) }
      before { get "/devices/#{device_id}/generate_settings", headers: headers_admin }

      it 'returns the device' do
        expect(json).not_to be_empty
        expect(json['device']['id']).to eq(device.id)
        expect(json['device']['name']).to eq(device.name)
      end

      it 'returns flow sensors' do
        expect(json).not_to be_empty
        expect(json['device']['flow_sensors'].size).to eq(3)
      end

      it 'returns rulers' do
        expect(json).not_to be_empty
        expect(json['device']['rulers'].size).to eq(5)
      end

      it 'returns user' do
        expect(json).not_to be_empty
        expect(json['user']['email']).to eq(user_admin.email)
        expect(json['user']['password']).to eq('your-password')
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:device_id) { 100 }
      before { get "/devices/#{device_id}/generate_settings", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Device with 'id'=#{device_id}")
      end
    end
  end
end