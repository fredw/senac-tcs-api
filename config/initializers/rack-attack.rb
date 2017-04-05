class Rack::Attack

  # Always allow requests from localhost
  safelist('allow-localhost') do |req|
   '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Throttle requests to 5 requests per second per ip
  throttle('req/ip', :limit => 10, :period => 1.second) do |req|
    #req.ip
    true
  end

  # Blocked response
  self.blocklisted_response = lambda do |env|
    [ 403, {'Content-Type' => 'application/json'}, [{error: 'Blocked.'}.to_json]]
  end

  # Rate-limit response
  self.throttled_response = lambda do |env|
    now = Time.now
    match_data = env['rack.attack.match_data']
    headers = {
        'Content-Type' => 'application/json',
        'X-RateLimit-Limit' => match_data[:limit].to_s,
        'X-RateLimit-Remaining' => '0',
        'X-RateLimit-Reset' => (now + (match_data[:period] - now.to_i % match_data[:period])).to_s
    }
    [ 429, headers, [{error: 'Throttle limit reached. Retry later.'}.to_json]]
  end
end
