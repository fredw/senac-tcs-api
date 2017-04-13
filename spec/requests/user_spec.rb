require 'rails_helper'

RSpec.describe 'User', type: :request do

  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }
  let(:headers_user) { {'Authorization': sign_in(user), 'Content-Type': 'application/json'} }
  let(:headers_user_other) { {'Authorization': sign_in(create(:user)), 'Content-Type': 'application/json'} }

  describe 'GET /users' do
    let!(:users) { create_list(:user, 10) }

    context 'when user is an admin' do
      before { get '/users', headers: headers_admin }

      it 'returns users' do
        expect(json['data'].size).to eq(11)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when paginated' do
      before { get '/users?page=1&per_page=2', headers: headers_admin }

      it 'returns paginated users' do
        expect(json.size).to eq(2)
      end

      it 'returns total records header' do
        expect(response.headers['Total']).to eq('11')
      end

      it 'returns total per page header' do
        expect(response.headers['Per-Page']).to eq('2')
      end
    end

    context 'when user is not and admin' do
      before { get '/users', headers: headers_user }
      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /users/:id' do

    context 'when the record exists' do
      before { get "/users/#{user_id}", headers: headers_admin }

      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(user_id)
      end

      it 'returns status code 200 Success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user is not and admin' do
      before { get "/users/#{user_id}", headers: headers_user_other }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the user is not admin but can see their own data' do
      before { get "/users/#{user_id}", headers: headers_user }

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }
      before { get "/users/#{user_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find User with 'id'=#{user_id}")
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:valid_params) { { name: 'New Name' }.to_json }

    context 'when the record exists' do
      before { put "/users/#{user_id}", params: valid_params, headers: headers_admin }

      it 'updates the record' do
        expect(json['data']['attributes']['name']).to eq('New Name')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }
      before { put "/users/#{user_id}", params: valid_params, headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find User with 'id'=#{user_id}")
      end
    end

    context 'when user is not an admin' do
      before { put "/users/#{user_id}", params: valid_params, headers: headers_user }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /users/:id' do

    context 'when the record exists' do
      before { delete "/users/#{user_id}", headers: headers_admin }

      it 'returns status code 204 No Content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }
      before { delete "/users/#{user_id}", headers: headers_admin }

      it 'returns status code 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(json['error']).to eq("Couldn't find User with 'id'=#{user_id}")
      end
    end

    context 'when user is not an admin' do
      before { delete "/users/#{user_id}", headers: headers_user }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end