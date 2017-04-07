require 'rails_helper'

RSpec.describe 'Customer', type: :request do

  let(:user_admin) { create(:user_admin) }
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }
  let(:customer_id) { customer.id }
  let!(:headers_admin) { {'Authorization': sign_in(user_admin), 'Content-Type': 'application/json'} }

  describe 'GET /customers' do
    let!(:customers) { FactoryGirl.create_list(:customer, 10) }

    context 'when user is an admin' do
      before { get '/customers', headers: headers_admin }

      it 'returns customers' do
        expect(json.size).to eq(11)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not and admin' do
      before { get '/customers', headers: { 'Authorization': sign_in(user) } }
      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /customers/:id' do
    before { get "/customers/#{customer_id}", headers: { 'Authorization': sign_in(user_admin) } }

    context 'when the record exists' do
      it 'returns the customer' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(customer_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:customer_id) { 100 }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Customer with 'id'=#{customer_id}")
      end
    end
  end

  describe 'POST /customers' do
    let!(:valid_params) { { name: 'Customer A', active: true }.to_json }

    context 'when the request is valid' do
      before { post '/customers', params: valid_params, headers: headers_admin }

      it 'creates a customer' do
        expect(json['name']).to eq('Customer A')
        expect(json['active']).to eq(true)
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request doesn\'t have name' do
      before { post '/customers', params: { active: true }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have status' do
      before { post '/customers', params: { name: 'Foobar' }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['active']).to eq(['can\'t be blank'])
      end
    end
  end
end