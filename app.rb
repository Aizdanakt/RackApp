# frozen_string_literal: true

require_relative 'request_handler'

class App

  STATUS = 200

  def call(env)
    result = TimeService.new
    options = RequestHandler.new.param_parser(env)

    if success?(result, options)
      [STATUS, headers, ["#{result.valid_options(options)}\n"]]
    else
      [400, headers, ["Unknown time format #{result.invalid_options(options)}\n"]]
    end
  end

  private

  def success?(result, options)
    options.all? { |item| result.formats.include?(item) }
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end
end
