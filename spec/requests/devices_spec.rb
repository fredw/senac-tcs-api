require 'rails_helper'

RSpec.describe 'Device', type: :request do

  let(:device) { create(:device) }
  let(:device_id) { device.id }
  let(:reservoir) { create(:reservoir) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /devices' do
    let!(:devices) { create_list(:device, 10, reservoir_id: reservoir.id) }

    context 'when user is an admin' do
      before { get "/reservoirs/#{reservoir.id}/devices", headers: headers_admin }

      it 'returns devices' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get "/reservoirs/#{reservoir.id}/devices?page=1&per_page=2", headers: headers_admin }

      it 'returns paginated devices' do
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

  describe 'GET /devices/:id' do

    context 'when the record exists' do
      before { get "/devices/#{device_id}", headers: headers_admin }

      it 'returns the device' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(device_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:device_id) { 100 }
      before { get "/devices/#{device_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Device with 'id'=#{device_id}")
      end
    end
  end

  describe 'POST /devices' do
    let!(:valid_params) { { name: 'Device A', description: 'Domuss experimentum!', reservoir_id: reservoir.id }.to_json }

    context 'when the request is valid' do
      before { post "/reservoirs/#{reservoir.id}/devices", params: valid_params, headers: headers_admin }

      it 'creates a device' do
        expect(json['data']['attributes']['name']).to eq('Device A')
        expect(json['data']['attributes']['description']).to eq('Domuss experimentum!')
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have name' do
      before { post "/reservoirs/#{reservoir.id}/devices", params: { description: 'Domuss experimentum!', reservoir_id: reservoir.id }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have reservoir' do
      before { post "/reservoirs/#{reservoir.id}/devices", params: { name: 'Device A' }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['reservoir']).to eq(['must exist'])
      end
    end
  end

  describe 'PUT /devices/:id' do
    let(:valid_params) { { name: 'Device X' }.to_json }

    context 'when the record exists' do
      before { put "/devices/#{device_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['name']).to eq('Device X')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:device_id) { 100 }
      before { put "/devices/#{device_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Device with 'id'=#{device_id}")
      end
    end
  end

  describe 'DELETE /devices/:id' do

    context 'when the record exists' do
      before { delete "/devices/#{device_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:device_id) { 100 }
      before { delete "/devices/#{device_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Device with 'id'=#{device_id}")
      end
    end
  end
end