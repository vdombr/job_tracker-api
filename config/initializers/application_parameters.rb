Rivulet::Application.setting :params do
  setting :token_key
end

Rivulet.configure do |config|
  config.params.token_key = ENV.fetch('APP_TOKEN_KEY')
end
