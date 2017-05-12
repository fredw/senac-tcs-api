require 'rails_helper'

RSpec.describe 'RulerData', type: :request do

  let(:ruler_data) { create(:ruler_data) }
  let(:ruler_data_id) { ruler_data.id }
  let(:ruler) { create(:ruler) }
  let(:ruler_other) { create(:ruler) }
  let(:level_sensor_1) { create(:level_sensor, ruler: ruler) }
  let(:level_sensor_2) { create(:level_sensor, ruler: ruler) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /rulers_data' do
    let!(:rulers_data) { create_list(:ruler_data, 10, ruler_id: ruler.id) }

    context 'when user is an admin' do
      before { get "/rulers/#{ruler.id}/rulers_data", headers: headers_admin }

      it 'returns rulers_data' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get "/rulers/#{ruler.id}/rulers_data?page=1&per_page=2", headers: headers_admin }

      it 'returns paginated rulers_data' do
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

  describe 'GET /rulers_data_last' do
    let!(:rulers_data) { create_list(:ruler_data, 10, ruler_id: ruler.id) }

    context 'when user is an admin' do
      before { get "/rulers/#{ruler.id}/rulers_data_last", headers: headers_admin }

      it 'returns the ruler data' do
        expect(json).not_to be_empty
        expect(json['data'][0]['id']).to eq(rulers_data.last.id)
        expect(json['data'][0]['attributes']['ruler']['id']).to eq(rulers_data.last.ruler.id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /rulers_data/:id' do

    context 'when the record exists' do
      before { get "/rulers_data/#{ruler_data_id}", headers: headers_admin }

      it 'returns the ruler_data' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(ruler_data_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:ruler_data_id) { 100 }
      before { get "/rulers_data/#{ruler_data_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find RulerData with 'id'=#{ruler_data_id}")
      end
    end
  end

  describe 'POST /rulers_data' do
    let(:sensor_params) do
      [
        { switched_on: true, level_sensor_id: level_sensor_1.id},
        { switched_on: false, level_sensor_id: level_sensor_2.id}
      ]
    end
    let!(:valid_params) { { ruler_id: ruler.id, level_sensor_data_attributes: sensor_params }.to_json }

    context 'when the request is valid' do
      before { post "/rulers/#{ruler.id}/rulers_data", params: valid_params, headers: headers_admin }

      it 'creates a ruler_data' do
        expect(json['data']['attributes']['ruler']['id']).to eq(ruler.id)
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have all level sensors' do
      let(:invalid_sensor_params) { [{ switched_on: true, level_sensor_id: level_sensor_1.id}] }
      let(:invalid_params) { { ruler_id: ruler.id, level_sensor_data_attributes: invalid_sensor_params }.to_json  }
      before { post "/rulers/#{ruler.id}/rulers_data", params: invalid_params, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['level_sensor_data']).to eq(['It\'s necessary to inform all sensors of this ruler'])
      end
    end

    context 'when the request doesn\'t have ruler' do
      before { post "/rulers/#{ruler.id}/rulers_data", params: { level_sensor_data_attributes: sensor_params }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['ruler']).to eq(['must exist', 'can\'t be blank'])
      end
    end
  end
end