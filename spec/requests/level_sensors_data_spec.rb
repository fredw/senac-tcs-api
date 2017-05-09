require 'rails_helper'

RSpec.describe 'LevelSensorData', type: :request do

  let(:level_sensor_data) { create(:level_sensor_data) }
  let(:level_sensor_data_id) { level_sensor_data.id }
  let(:level_sensor) { create(:level_sensor) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /level_sensors_data' do
    let!(:level_sensors_data) { create_list(:level_sensor_data, 10, level_sensor_id: level_sensor.id) }

    context 'when user is an admin' do
      before { get "/level_sensors/#{level_sensor.id}/level_sensors_data", headers: headers_admin }

      it 'returns level_sensors_data' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get "/level_sensors/#{level_sensor.id}/level_sensors_data?page=1&per_page=2", headers: headers_admin }

      it 'returns paginated level_sensors_data' do
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

  describe 'GET /level_sensors_data/:id' do

    context 'when the record exists' do
      before { get "/level_sensors_data/#{level_sensor_data_id}", headers: headers_admin }

      it 'returns the level_sensor_data' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(level_sensor_data_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:level_sensor_data_id) { 100 }
      before { get "/level_sensors_data/#{level_sensor_data_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find LevelSensorData with 'id'=#{level_sensor_data_id}")
      end
    end
  end

  describe 'POST /level_sensors_data' do
    let!(:valid_params) { { switched_on: true, level_sensor_id: level_sensor.id }.to_json }

    context 'when the request is valid' do
      before { post "/level_sensors/#{level_sensor.id}/level_sensors_data", params: valid_params, headers: headers_admin }

      it 'creates a level_sensor_data' do
        expect(json['data']['attributes']['switched-on']).to eq(true)
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have level sensor' do
      before { post "/level_sensors/#{level_sensor.id}/level_sensors_data", params: { switched_on: true }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['level_sensor']).to eq(['must exist'])
      end
    end
  end

  describe 'PUT /level_sensors_data/:id' do
    let(:valid_params) { { switched_on: false }.to_json }

    context 'when the record exists' do
      before { put "/level_sensors_data/#{level_sensor_data_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['switched-on']).to eq(false)
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:level_sensor_data_id) { 100 }
      before { put "/level_sensors_data/#{level_sensor_data_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find LevelSensorData with 'id'=#{level_sensor_data_id}")
      end
    end
  end

  describe 'DELETE /level_sensors_data/:id' do

    context 'when the record exists' do
      before { delete "/level_sensors_data/#{level_sensor_data_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:level_sensor_data_id) { 100 }
      before { delete "/level_sensors_data/#{level_sensor_data_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find LevelSensorData with 'id'=#{level_sensor_data_id}")
      end
    end
  end
end