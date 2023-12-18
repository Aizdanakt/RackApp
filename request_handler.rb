# frozen_string_literal: true

require_relative 'services/time_service'

class RequestHandler

  def param_parser(params)
    Rack::Request.new(params).params['format'].split(',')
  end

end
