require 'rails_helper'

RSpec.describe 'Reservoir', type: :request do

  let(:reservoir_group) { create(:reservoir_group) }
  let(:reservoir_group_id) { reservoir_group.id }
  let(:customer) { create(:customer) }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }
  let(:headers_user) { {'Authorization': sign_in(create(:user)), 'Content-Type': 'application/json'} }
  let(:headers_user_other) { {'Authorization': sign_in(create(:user, customer: customer)), 'Content-Type': 'application/json'} }

  describe 'GET /reservoir_groups' do
    let!(:reservoir_groups) { create_list(:reservoir_group, 10) }

    context 'when user is an admin' do
      before { get '/reservoir_groups', headers: headers_admin }

      it 'returns reservoir groups' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get '/reservoir_groups?page=1&per_page=2', headers: headers_admin }

      it 'returns paginated reservoir_groups' do
        expect(json.size).to eq(2)
      end

      it 'returns total records header' do
        expect(response.headers['Total']).to eq('10')
      end

      it 'returns total per page header' do
        expect(response.headers['Per-Page']).to eq('2')
      end
    end

    context 'when user is not and admin' do
      before { get '/reservoir_groups', headers: headers_user }

      it 'returns reservoir groups' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /reservoir_groups/:id' do

    context 'when the record exists' do
      before { get "/reservoir_groups/#{reservoir_group_id}", headers: headers_admin }

      it 'returns the reservoir_group' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(reservoir_group_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record exists and user is the owner' do
      before { get "/reservoir_groups/#{reservoir_group_id}", headers: headers_user }

      it 'returns the reservoir_group' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(reservoir_group_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record exists and user is not the owner' do
      before { get "/reservoir_groups/#{reservoir_group_id}", headers: headers_user_other }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the record does not exist' do
      let(:reservoir_group_id) { 100 }
      before { get "/reservoir_groups/#{reservoir_group_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find ReservoirGroup with 'id'=#{reservoir_group_id}")
      end
    end
  end

  describe 'POST /reservoir_groups' do
    let!(:valid_params) { { name: 'Reservoir Group A', customer_id: customer.id }.to_json }

    context 'when the request is valid' do
      before { post '/reservoir_groups', params: valid_params, headers: headers_admin }

      it 'creates a reservoir_group' do
        expect(json['data']['attributes']['name']).to eq('Reservoir Group A')
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have name' do
      before { post '/reservoir_groups', params: { customer_id: customer.id }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have customer' do
      before { post '/reservoir_groups', params: { name: 'Reservoir Group A' }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['customer']).to eq(['must exist'])
      end
    end

    context 'when user is not an admin' do
      before { post '/reservoir_groups', params: valid_params, headers: headers_user }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /reservoir_groups/:id' do
    let(:valid_params) { { name: 'Reservoir Group X' }.to_json }

    context 'when the record exists' do
      before { put "/reservoir_groups/#{reservoir_group_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['name']).to eq('Reservoir Group X')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:reservoir_group_id) { 100 }
      before { put "/reservoir_groups/#{reservoir_group_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find ReservoirGroup with 'id'=#{reservoir_group_id}")
      end
    end

    context 'when user is not an admin' do
      before { put "/reservoir_groups/#{reservoir_group_id}", params: valid_params, headers: headers_user }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /reservoir_groups/:id' do

    context 'when the record exists' do
      before { delete "/reservoir_groups/#{reservoir_group_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:reservoir_group_id) { 100 }
      before { delete "/reservoir_groups/#{reservoir_group_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find ReservoirGroup with 'id'=#{reservoir_group_id}")
      end
    end

    context 'when user is not an admin' do
      before { delete "/reservoir_groups/#{reservoir_group_id}", headers: headers_user }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end