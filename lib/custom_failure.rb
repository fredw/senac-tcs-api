class CustomFailure < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'json'
    self.response_body = {:error => 'Invalid token'}.to_json
  end
end