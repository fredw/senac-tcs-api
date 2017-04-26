require 'rails_helper'

RSpec.describe 'Reservoir', type: :request do

  let(:reservoir) { create(:reservoir) }
  let(:reservoir_id) { reservoir.id }
  let(:customer) { create(:customer) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /reservoirs' do
    let!(:reservoirs) { create_list(:reservoir, 10) }

    context 'when user is an admin' do
      before { get '/reservoirs', headers: headers_admin }

      it 'returns reservoirs' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get '/reservoirs?page=1&per_page=2', headers: headers_admin }

      it 'returns paginated reservoirs' do
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

  describe 'GET /reservoirs/:id' do

    context 'when the record exists' do
      before { get "/reservoirs/#{reservoir_id}", headers: headers_admin }

      it 'returns the reservoir' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(reservoir_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:reservoir_id) { 100 }
      before { get "/reservoirs/#{reservoir_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Reservoir with 'id'=#{reservoir_id}")
      end
    end
  end

  describe 'POST /reservoirs' do
    let!(:valid_params) { { name: 'Reservoir A', description: 'Lorem ipsum', volume: 3.78, customer_id: customer.id }.to_json }

    context 'when the request is valid' do
      before { post '/reservoirs', params: valid_params, headers: headers_admin }

      it 'creates a reservoir' do
        expect(json['data']['attributes']['name']).to eq('Reservoir A')
        expect(json['data']['attributes']['description']).to eq('Lorem ipsum')
        expect(json['data']['attributes']['volume']).to eq('3.78')
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have name' do
      before { post '/reservoirs', params: { description: 'Lorem ipsum', volume: 3.78 }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have volume' do
      before { post '/reservoirs', params: { name: 'Reservoir A', description: 'Lorem ipsum' }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['volume']).to eq(['can\'t be blank'])
      end
    end
  end

  describe 'PUT /reservoirs/:id' do
    let(:valid_params) { { name: 'Reservoir X', description: 'Other lorem ipsum', volume: 14.59 }.to_json }

    context 'when the record exists' do
      before { put "/reservoirs/#{reservoir_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['name']).to eq('Reservoir X')
        expect(json['data']['attributes']['description']).to eq('Other lorem ipsum')
        expect(json['data']['attributes']['volume']).to eq('14.59')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:reservoir_id) { 100 }
      before { put "/reservoirs/#{reservoir_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Reservoir with 'id'=#{reservoir_id}")
      end
    end
  end

  describe 'DELETE /reservoirs/:id' do

    context 'when the record exists' do
      before { delete "/reservoirs/#{reservoir_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:reservoir_id) { 100 }
      before { delete "/reservoirs/#{reservoir_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Reservoir with 'id'=#{reservoir_id}")
      end
    end
  end
end