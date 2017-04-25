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
        expect(json.size).to eq(2)
      end

      it 'returns total records header' do
        expect(response.headers['Total']).to eq('10')
      end

      it 'returns total per page header' do
        expect(response.headers['Per-Page']).to eq('2')
      end
    end
  end

  # describe 'GET /flow_sensors_data/:id' do
  #
  #   context 'when the record exists' do
  #     before { get "/flow_sensors_data/#{flow_sensor_data_id}", headers: headers_admin }
  #
  #     it 'returns the flow_sensor_data' do
  #       expect(json).not_to be_empty
  #       expect(json['data']['id']).to eq(flow_sensor_data_id)
  #     end
  #
  #     it 'returns status code 200 Success' do
  #       expect(response).to have_http_status(:success)
  #     end
  #   end
  #
  #   context 'when the record does not exist' do
  #     let(:flow_sensor_data_id) { 100 }
  #     before { get "/flow_sensors_data/#{flow_sensor_data_id}", headers: headers_admin }
  #
  #     it 'returns status code 404 Not Found' do
  #       expect(response).to have_http_status(:not_found)
  #     end
  #
  #     it 'returns a not found message' do
  #       expect(json['error']).to eq("Couldn't find FlowSensorData with 'id'=#{flow_sensor_data_id}")
  #     end
  #   end
  # end
  #
  # describe 'POST /flow_sensors_data' do
  #   let!(:valid_params) { { pin: 'A2', flow_sensor_id: flow_sensor.id }.to_json }
  #
  #   context 'when the request is valid' do
  #     before { post "/flow_sensors/#{flow_sensor.id}/flow_sensors_data", params: valid_params, headers: headers_admin }
  #
  #     it 'creates a flow_sensor_data' do
  #       expect(json['data']['attributes']['pin']).to eq('A2')
  #     end
  #
  #     it 'returns status code 201 Created' do
  #       expect(response).to have_http_status(:created)
  #     end
  #   end
  #
  #   context 'when the request doesn\'t have pin' do
  #     before { post "/flow_sensors/#{flow_sensor.id}/flow_sensors_data", params: { flow_sensor_id: flow_sensor.id }.to_json, headers: headers_admin }
  #
  #     it 'returns status code 422 Unprocessable Entity' do
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #
  #     it 'returns a validation failure message' do
  #       expect(json['pin']).to eq(['can\'t be blank', 'is the wrong length (should be 2 characters)'])
  #     end
  #   end
  #
  #   context 'when the request doesn\'t have flow sensor' do
  #     before { post "/flow_sensors/#{flow_sensor.id}/flow_sensors_data", params: { pin: 'A2' }.to_json, headers: headers_admin }
  #
  #     it 'returns status code 422 Unprocessable Entity' do
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #
  #     it 'returns a validation failure message' do
  #       expect(json['flow_sensor']).to eq(['must exist'])
  #     end
  #   end
  # end
  #
  # describe 'PUT /flow_sensors_data/:id' do
  #   let(:valid_params) { { pin: 'A8' }.to_json }
  #
  #   context 'when the record exists' do
  #     before { put "/flow_sensors_data/#{flow_sensor_data_id}", params: valid_params, headers: headers_admin }
  #
  #     it 'updates the record' do
  #       expect(json['data']['attributes']['pin']).to eq('A8')
  #     end
  #
  #     it 'returns status code 200 OK' do
  #       expect(response).to have_http_status(:ok)
  #     end
  #   end
  #
  #   context 'when the record does not exist' do
  #     let(:flow_sensor_data_id) { 100 }
  #     before { put "/flow_sensors_data/#{flow_sensor_data_id}", params: valid_params, headers: headers_admin }
  #
  #     it 'returns status code 404 Not Found' do
  #       expect(response).to have_http_status(:not_found)
  #     end
  #
  #     it 'returns a not found message' do
  #       expect(json['error']).to eq("Couldn't find FlowSensorData with 'id'=#{flow_sensor_data_id}")
  #     end
  #   end
  # end
  #
  # describe 'DELETE /flow_sensors_data/:id' do
  #
  #   context 'when the record exists' do
  #     before { delete "/flow_sensors_data/#{flow_sensor_data_id}", headers: headers_admin }
  #
  #     it 'returns status code 204 No Content' do
  #       expect(response).to have_http_status(:no_content)
  #     end
  #   end
  #
  #   context 'when the record does not exist' do
  #     let(:flow_sensor_data_id) { 100 }
  #     before { delete "/flow_sensors_data/#{flow_sensor_data_id}", headers: headers_admin }
  #
  #     it 'returns status code 404 Not Found' do
  #       expect(response).to have_http_status(:not_found)
  #     end
  #
  #     it 'returns a not found message' do
  #       expect(json['error']).to eq("Couldn't find FlowSensorData with 'id'=#{flow_sensor_data_id}")
  #     end
  #   end
  # end
end