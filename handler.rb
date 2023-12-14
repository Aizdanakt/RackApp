# frozen_string_literal: true

require 'rack'

app = proc do |env|
  [
    200,
    { 'Content-Type' => 'text/plain' },
    ["Welcome abroad!\n"]
  ]
end

Rack::Handler::WEBrick.run app