require 'rails_helper'

RSpec.describe 'FlowSensorData', type: :request do

  let(:flow_sensor_data) { create(:flow_sensor_data) }
  let(:flow_sensor_data_id) { flow_sensor_data.id }
  let(:flow_sensor) { create(:flow_sensor) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /flow_sensors_data' do
    let!(:flow_sensors_data) { create_list(:flow_sensor_data, 10, flow_sensor_id: flow_sensor.id) }

    context 'when user is an admin' do
      before { get "/flow_sensors/#{flow_sensor.id}/flow_sensors_data", headers: headers_admin }

      it 'returns flow_sensors_data' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get "/flow_sensors/#{flow_sensor.id}/flow_sensors_data?page=1&per_page=2", headers: headers_admin }

      it 'returns paginated flow_sensors_data' do
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

  describe 'GET /flow_sensors_data_last' do
    let!(:flow_sensors_data) { create_list(:flow_sensor_data, 10, flow_sensor_id: flow_sensor.id) }

    context 'when user is an admin' do
      before { get "/flow_sensors/#{flow_sensor.id}/flow_sensors_data_last", headers: headers_admin }

      it 'returns the flow_sensor_data' do
        expect(json).not_to be_empty
        expect(json['data'][0]['id']).to eq(flow_sensors_data.last.id)
        expect(json['data'][0]['attributes']['consumption-per-minute']).to eq(flow_sensors_data.last.consumption_per_minute.to_s)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /flow_sensors_data/:id' do

    context 'when the record exists' do
      before { get "/flow_sensors_data/#{flow_sensor_data_id}", headers: headers_admin }

      it 'returns the flow_sensor_data' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(flow_sensor_data.id)
        expect(json['data']['attributes']['consumption-per-minute']).to eq(flow_sensor_data.consumption_per_minute.to_s)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:flow_sensor_data_id) { 100 }
      before { get "/flow_sensors_data/#{flow_sensor_data_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find FlowSensorData with 'id'=#{flow_sensor_data_id}")
      end
    end
  end

  describe 'POST /flow_sensors_data' do
    let!(:valid_params) { { consumption_per_minute: 19.7, flow_sensor_id: flow_sensor.id }.to_json }

    context 'when the request is valid' do
      before { post "/flow_sensors/#{flow_sensor.id}/flow_sensors_data", params: valid_params, headers: headers_admin }

      it 'creates a flow_sensor_data' do
        expect(json['data']['attributes']['consumption-per-minute']).to eq('19.7')
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have consumption per minute' do
      before { post "/flow_sensors/#{flow_sensor.id}/flow_sensors_data", params: { flow_sensor_id: flow_sensor.id }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['consumption_per_minute']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have flow sensor' do
      before { post "/flow_sensors/#{flow_sensor.id}/flow_sensors_data", params: { consumption_per_minute: 19.7 }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['flow_sensor']).to eq(['must exist'])
      end
    end
  end
end