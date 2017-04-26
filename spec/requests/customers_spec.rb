require 'rails_helper'

RSpec.describe 'Customer', type: :request do

  let(:customer) { create(:customer) }
  let(:customer_id) { customer.id }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /customers' do
    let!(:customers) { create_list(:customer, 10) }

    context 'when user is an admin' do
      before { get '/customers', headers: headers_admin }

      it 'returns customers' do
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get '/customers?page=1&per_page=2', headers: headers_admin }

      it 'returns paginated customers' do
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

  describe 'GET /customers/:id' do

    context 'when the record exists' do
      before { get "/customers/#{customer_id}", headers: headers_admin }

      it 'returns the customer' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(customer_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:customer_id) { 100 }
      before { get "/customers/#{customer_id}", headers: headers_admin }

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
        expect(json['data']['attributes']['name']).to eq('Customer A')
        expect(json['data']['attributes']['active']).to eq(true)
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

    context 'when the request doesn\'t have active' do
      before { post '/customers', params: { name: 'Foobar' }.to_json, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['active']).to eq(['is not included in the list'])
      end
    end
  end

  describe 'PUT /customers/:id' do
    let(:valid_params) { { name: 'Customer X' }.to_json }

    context 'when the record exists' do
      before { put "/customers/#{customer_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['name']).to eq('Customer X')
        expect(json['data']['attributes']['active']).to eq(true)
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:customer_id) { 100 }
      before { put "/customers/#{customer_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Customer with 'id'=#{customer_id}")
      end
    end
  end

  describe 'DELETE /customers/:id' do

    context 'when the record exists' do
      before { delete "/customers/#{customer_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:customer_id) { 100 }
      before { delete "/customers/#{customer_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Customer with 'id'=#{customer_id}")
      end
    end
  end
end