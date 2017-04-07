module AuthenticationHelper
  def sign_in(user)
    post '/users/sign_in', params: { user: { email: user.email, password: user.password } }
    response.headers['Authorization']
  end
end