# frozen_string_literal: true

require_relative 'services/time_service'

class RequestHandler
  def call(env)
    TimeService.new.call(param_parser(env))
  end

  private

  def param_parser(params)
    Rack::Request.new(params).params['format'].split(',')
  end

end
