# frozen_string_literal: true

require_relative 'time_handler'

class App

  def call(env)
    time_handler = TimeHandler.new(env)
    time_handler.call

    if time_handler.valid_request?
      if time_handler.valid?
        [status, headers, ["#{time_handler.valid_options}\n"]]
      else
        [400, headers, ["Unknown time format #{time_handler.invalid_options}\n"]]
      end
    else
      [404, headers, ["Not Found\n"]]
    end
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => nil }
  end
end
