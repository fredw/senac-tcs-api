require 'rails_helper'

RSpec.describe 'Role', type: :request do

  let(:role) { create(:role_user) }
  let(:role_id) { role.id }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'GET /roles' do
    let!(:roles) { create_list(:role_user, 10) }

    context 'when user is an admin' do
      before { get '/roles', headers: headers_admin }

      it 'returns roles' do
        expect(json['data'].size).to eq(11)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get '/roles?page=1&per_page=2', headers: headers_admin }

      it 'returns paginated roles' do
        expect(json.size).to eq(2)
      end

      it 'returns total records header' do
        expect(response.headers['Total']).to eq('11')
      end

      it 'returns total per page header' do
        expect(response.headers['Per-Page']).to eq('2')
      end
    end
  end

  describe 'GET /roles/:id' do

    context 'when the record exists' do
      before { get "/roles/#{role_id}", headers: headers_admin }

      it 'returns the role' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(role_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:role_id) { 100 }
      before { get "/roles/#{role_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find Role with 'id'=#{role_id}")
      end
    end
  end
end