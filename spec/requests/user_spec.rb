require 'rails_helper'

RSpec.describe 'User', type: :request do

  let!(:user) { create(:user) }
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { user.first.id }

  describe 'POST /users/sign_in' do

    let!(:valid_params) { { user: { email: user.email, password: user.password } } }
    let!(:unvalid_params) { { user: { email: 'invalid@teste.com', password: '123' } } }

    context 'when the request is valid' do
      before { post '/users/sign_in', params: valid_params }

      it 'returns valid user data' do
        expect(json['id']).to eq(user.id)
        expect(json['email']).to eq(user.email)
        expect(json['name']).to eq(user.name)
      end

      it 'returns status code 201 Created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns valid authorization header' do
        expect(response.headers).to have_key('Authorization')
        expect(response.headers['Authorization']).to match(/(.+)\.(.+)\.(.+)/)
      end
    end

    context 'when the request is invalid' do
      before { post '/users/sign_in', params: unvalid_params }

      it 'signs fail' do
        expect(json['error']).to eq('Invalid Email or password.')
      end

      it 'returns status code 401 Unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end