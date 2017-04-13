require 'rails_helper'

RSpec.describe 'User Devise', type: :request do

  let!(:user) { create(:user) }
  let!(:headers_user) { {'Authorization': sign_in(user), 'Content-Type': 'application/json'} }
  let!(:headers_admin) { {'Authorization': sign_in(create(:user_admin)), 'Content-Type': 'application/json'} }

  describe 'POST /users' do
    let(:valid_user) { attributes_for(:user) }
    let(:role) { Role.find_by_symbol(Role.symbols.fetch(:user)) }
    let(:valid_params) do
      {
        user: {
          name: valid_user[:name],
          email: valid_user[:email],
          password: valid_user[:password],
          password_confirmation: valid_user[:password_confirmation],
          customer_id: valid_user[:customer][:id],
          role_id: role.id
        }
      }.to_json
    end

    context 'when token is invalid' do
      before { post '/users', params: valid_params, headers: {'Authorization': 'invalid-token', 'Content-Type': 'application/json'} }

      it 'returns invalid token' do
        expect(json['error']).to eq('Invalid token')
      end

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the request is valid' do
      before { post '/users', params: valid_params, headers: headers_admin }

      it 'creates a user' do
        expect(json['data']['id']).not_to be_nil
        expect(json['data']['attributes']['name']).to eq(valid_user[:name])
        expect(json['data']['attributes']['email']).to eq(valid_user[:email])
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the request doesn\'t have name' do
      let(:invalid_params) do
        params = JSON.parse(valid_params, :symbolize_names => true)
        params[:user].delete(:name)
        params.to_json
      end
      before { post '/users', params: invalid_params, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to eq(['can\'t be blank'])
      end
    end

    context 'when the request doesn\'t have email' do
      let(:invalid_params) do
        params = JSON.parse(valid_params, :symbolize_names => true)
        params[:user].delete(:email)
        params.to_json
      end
      before { post '/users', params: invalid_params, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['email']).to eq(['can\'t be blank'])
      end
    end

    context 'when the email is invalid' do
      let(:invalid_params) do
        params = JSON.parse(valid_params, :symbolize_names => true)
        params[:user][:email] = 'invalid'
        params.to_json
      end
      before { post '/users', params: invalid_params, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['email']).to eq(['is invalid'])
      end
    end

    context 'when the request doesn\'t have customer' do
      let(:invalid_params) do
        params = JSON.parse(valid_params, :symbolize_names => true)
        params[:user].delete(:customer_id)
        params.to_json
      end
      before { post '/users', params: invalid_params, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['customer']).to eq(['must exist'])
      end
    end

    context 'when the request doesn\'t have role' do
      let(:invalid_params) do
        params = JSON.parse(valid_params, :symbolize_names => true)
        params[:user].delete(:role_id)
        params.to_json
      end
      before { post '/users', params: invalid_params, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['role']).to eq(['must exist'])
      end
    end

    context 'when the password confirmation is wrong' do
      let(:invalid_params) do
        params = JSON.parse(valid_params, :symbolize_names => true)
        params[:user][:password] = '123'
        params.to_json
      end
      before { post '/users', params: invalid_params, headers: headers_admin }

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(json['password_confirmation']).to eq(['doesn\'t match Password'])
      end
    end

    context 'when user is not an admin' do
      before { post '/users', params: valid_params, headers: headers_user }

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /users/sign_in' do

    context 'when the request is valid' do
      let!(:valid_params) { { user: { email: user.email, password: user.password } } }
      before { post '/users/sign_in', params: valid_params }

      it 'returns no content' do
        expect(json['data']['id']).to eq(user.id)
        expect(json['data']['attributes']['email']).to eq(user.email)
        expect(json['data']['attributes']['name']).to eq(user.name)
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns valid authorization header' do
        expect(response.headers).to have_key('Authorization')
        expect(response.headers['Authorization']).to match(/(.+)\.(.+)\.(.+)/)
      end
    end

    context 'when the request is invalid' do
      let!(:unvalid_params) { { user: { email: 'invalid@teste.com', password: '123' } } }
      before { post '/users/sign_in', params: unvalid_params }

      it 'signs fail' do
        expect(json['error']).to eq('Invalid token')
      end

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /users/sign_out' do

    context 'when user signed in' do
      before { delete '/users/sign_out', headers: headers_user }

      it 'returns no content' do
        expect(json['success']).to eq('Signed out')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not signed in' do
      before { delete '/users/sign_out', headers: {'Content-Type': 'application/json'} }

      it 'returns invalid token' do
        expect(json['error']).to eq('Invalid token')
      end

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /users/password' do

    context 'when email is valid' do
      let(:valid_params) { { user: { email: user.email } }.to_json }
      before { post '/users/password', params: valid_params, headers: headers_user }

      it 'returns no content' do
        expect(json['success']).to eq('Confirmation e-mail sent')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when email is invalid' do
      let(:invalid_params) { { user: { email: 'inexistent@email.com' } }.to_json }
      before { post '/users/password', params: invalid_params, headers: headers_user }

      it 'returns no content' do
        expect(json['email']).to eq(['not found'])
      end

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /users/password' do

    context 'when token is valid' do
      let(:token) { user.send_reset_password_instructions }
      let(:valid_params) { { user: { reset_password_token: token, password: user.password } }.to_json }
      before { put '/users/password', params: valid_params, headers: headers_user }

      it 'updates the password' do
        expect(json['data']['id']).to eq(user.id)
        expect(json['data']['attributes']['name']).to eq(user.name)
        expect(json['data']['attributes']['email']).to eq(user.email)
      end

      it 'returns status code 200 OK' do
        Rails.logger.info('###1###')
        Rails.logger.info(json)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when token is invalid' do
      let(:invalid_params) { { user: { reset_password_token: 'bad-reset-token' } }.to_json }
      before { put '/users/password', params: invalid_params, headers: headers_user }

      it 'show token invalid' do
        expect(json['reset_password_token']).to eq(['is invalid'])
      end

      it 'returns status code 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /users' do

    context 'when changes the name' do
      let(:valid_params) { { user: { name: 'New name', current_password: user.password } }.to_json }
      before { put '/users', params: valid_params, headers: headers_user }

      it 'returns the user' do
        expect(json['data']['id']).to eq(user['id'])
        expect(json['data']['attributes']['name']).to eq('New name')
      end

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when changes the email' do
      let(:valid_params) { { user: { email: 'new@email.com', current_password: user.password } }.to_json }
      before { put '/users', params: valid_params, headers: headers_user }

      it 'returns status code 200 OK' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when password is invalid' do
      let(:invalid_params) { { user: { name: user.name, current_password: 'wrong-passsword' } }.to_json }
      before { put '/users', params: invalid_params, headers: headers_user }

      it 'returns the user' do
        expect(json['current_password']).to eq(['is invalid'])
      end

      it 'returns status code 422 Unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end