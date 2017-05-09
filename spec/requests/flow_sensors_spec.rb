require 'rails_helper'

RSpec.describe 'FlowSensor', type: :request do

  let(:flow_sensor) { create(:flow_sensor) }
  let(:flow_sensor_id) { flow_sensor.id }
  let(:device) { create(:device) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /flow_sensors' do
    let!(:flow_sensors) { create_list(:flow_sensor, 10, device_id: device.id) }

    context 'when user is an admin' do
      before { get "/devices/#{device.id}/flow_sensors", headers: headers_admin }

      it 'returns flow_sensors' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get "/devices/#{device.id}/flow_sensors?page=1&per_page=2", headers: headers_admin }

      it 'returns paginated flow_sensors' do
        expect(json['data'].size).to eq(2)
      end

      it 'returns total records header' do
        expect(response.headers['Total']).to eq('10')
      end

      it 'returns total per page header' do
        expect(response.headers['Per-Page']).to eq('2')
      end
    end
  end

  describe 'GET /flow_sensors/:id' do

    context 'when the record exists' do
      before { get "/flow_sensors/#{flow_sensor_id}", headers: headers_admin }

      it 'returns the flow_sensor' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(flow_sensor_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:flow_sensor_id) { 100 }
      before { get "/flow_sensors/#{flow_sensor_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find FlowSensor with 'id'=#{flow_sensor_id}")
      end
    end
  end

  describe 'POST /flow_sensors' do
    let!(:valid_params) { { pin: 'A2', device_id: device.id }.to_json }

    context 'when the request is valid' do
      before { post "/devices/#{device.id}/flow_sensors", params: valid_params, headers: headers_admin }

      it 'creates a flow_sensor' do
        expect(json['data']['attributes']['pin']).to eq('A2')
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have pin' do
      before { post "/devices/#{device.id}/flow_sensors", params: { device_id: device.id }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['pin']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have device' do
      before { post "/devices/#{device.id}/flow_sensors", params: { pin: 'A2' }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['device']).to eq(['must exist'])
      end
    end
  end

  describe 'PUT /flow_sensors/:id' do
    let(:valid_params) { { pin: 'A8' }.to_json }

    context 'when the record exists' do
      before { put "/flow_sensors/#{flow_sensor_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['pin']).to eq('A8')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:flow_sensor_id) { 100 }
      before { put "/flow_sensors/#{flow_sensor_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find FlowSensor with 'id'=#{flow_sensor_id}")
      end
    end
  end

  describe 'DELETE /flow_sensors/:id' do

    context 'when the record exists' do
      before { delete "/flow_sensors/#{flow_sensor_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:flow_sensor_id) { 100 }
      before { delete "/flow_sensors/#{flow_sensor_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find FlowSensor with 'id'=#{flow_sensor_id}")
      end
    end
  end
end