# frozen_string_literal: true

require_relative 'request_handler'

class App

  STATUS = 200

  def call(env)
    result = RequestHandler.new.call(env)

    if result.success?
      [STATUS, headers, ["#{result.valid_options}\n"]]
    else
      [400, headers, ["Unknown time format #{result.invalid_options}\n"]]
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end
end
