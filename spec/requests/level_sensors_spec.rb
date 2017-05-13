require 'rails_helper'

RSpec.describe 'LevelSensor', type: :request do

  let(:level_sensor) { create(:level_sensor) }
  let(:level_sensor_id) { level_sensor.id }
  let(:ruler) { create(:ruler) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /level_sensors' do
    let!(:level_sensors) { create_list(:level_sensor, 10, ruler_id: ruler.id) }

    context 'when user is an admin' do
      before { get "/rulers/#{ruler.id}/level_sensors", headers: headers_admin }

      it 'returns level sensors' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get "/rulers/#{ruler.id}/level_sensors?page=1&per_page=2", headers: headers_admin }

      it 'returns paginated level_sensors' do
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

  describe 'GET /level_sensors/:id' do

    context 'when the record exists' do
      before { get "/level_sensors/#{level_sensor_id}", headers: headers_admin }

      it 'returns the level_sensor' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(level_sensor_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:level_sensor_id) { 100 }
      before { get "/level_sensors/#{level_sensor_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find LevelSensor with 'id'=#{level_sensor_id}")
      end
    end
  end

  describe 'POST /level_sensors' do
    let!(:valid_params) { { pin: 'A2', volume: 2.9, ruler_id: ruler.id }.to_json }

    context 'when the request is valid' do
      before { post "/rulers/#{ruler.id}/level_sensors", params: valid_params, headers: headers_admin }

      it 'creates a level_sensor' do
        expect(json['data']['attributes']['pin']).to eq('A2')
        expect(json['data']['attributes']['volume']).to eq('2.9')
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have pin' do
      before { post "/rulers/#{ruler.id}/level_sensors", params: { ruler_id: ruler.id }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['pin']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have ruler' do
      before { post "/rulers/#{ruler.id}/level_sensors", params: { pin: 'A2' }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['ruler']).to eq(['must exist'])
      end
    end
  end

  describe 'PUT /level_sensors/:id' do
    let(:valid_params) { { pin: 'A8', volume: 8.23 }.to_json }

    context 'when the record exists' do
      before { put "/level_sensors/#{level_sensor_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['pin']).to eq('A8')
        expect(json['data']['attributes']['volume']).to eq('8.23')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:level_sensor_id) { 100 }
      before { put "/level_sensors/#{level_sensor_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find LevelSensor with 'id'=#{level_sensor_id}")
      end
    end
  end

  describe 'DELETE /level_sensors/:id' do

    context 'when the record exists' do
      before { delete "/level_sensors/#{level_sensor_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:level_sensor_id) { 100 }
      before { delete "/level_sensors/#{level_sensor_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find LevelSensor with 'id'=#{level_sensor_id}")
      end
    end
  end
end