require 'rails_helper'

RSpec.describe 'Ruler', type: :request do

  let(:ruler) { create(:ruler) }
  let(:ruler_id) { ruler.id }
  let(:device) { create(:device) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /rulers' do
    let!(:rulers) { create_list(:ruler, 10, device_id: device.id) }

    context 'when user is an admin' do
      before { get "/devices/#{device.id}/rulers", headers: headers_admin }

      it 'returns rulers' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get "/devices/#{device.id}/rulers?page=1&per_page=2", headers: headers_admin }

      it 'returns paginated rulers' do
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

  describe 'GET /rulers/:id' do

    context 'when the record exists' do
      before { get "/rulers/#{ruler_id}", headers: headers_admin }

      it 'returns the ruler' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(ruler_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:ruler_id) { 100 }
      before { get "/rulers/#{ruler_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Ruler with 'id'=#{ruler_id}")
      end
    end
  end

  describe 'POST /rulers' do
    let!(:valid_params) { { height: 17.42, device_id: device.id }.to_json }

    context 'when the request is valid' do
      before { post "/devices/#{device.id}/rulers", params: valid_params, headers: headers_admin }

      it 'creates a ruler' do
        expect(json['data']['attributes']['height']).to eq('17.42')
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have height' do
      before { post "/devices/#{device.id}/rulers", params: { device_id: device.id }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['height']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have device' do
      before { post "/devices/#{device.id}/rulers", params: { height: 17.42 }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['device']).to eq(['must exist'])
      end
    end
  end

  describe 'PUT /rulers/:id' do
    let(:valid_params) { { height: 8.93 }.to_json }

    context 'when the record exists' do
      before { put "/rulers/#{ruler_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['height']).to eq('8.93')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:ruler_id) { 100 }
      before { put "/rulers/#{ruler_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Ruler with 'id'=#{ruler_id}")
      end
    end
  end

  describe 'DELETE /rulers/:id' do

    context 'when the record exists' do
      before { delete "/rulers/#{ruler_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:ruler_id) { 100 }
      before { delete "/rulers/#{ruler_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Ruler with 'id'=#{ruler_id}")
      end
    end
  end
end