# frozen_string_literal: true

require 'logger'

class TimeHandler

  FORMATS = %w[year month day hour minute second].freeze

  def initialize(app)
    @logger = Logger.new(STDOUT)
    @app = app
  end

  def call(env)
    if env['REQUEST_METHOD'] == 'GET' && env['PATH_INFO'] == '/time'
      result = decode_query_params(env)
      status, headers, body = @app.call(env)
      process_result(status, headers, body, result)
    else
      [404, { 'Content-Type' => 'text/plain' }, ['Not Found']]
    end
  end

  private

  def process_result(status, headers, body, result)
    if !result[:success]
      status = 400
      body = ["Unknown time format #{result[:bad_options]}"]
    else
      body = [result[:good_options].join('-')]
    end
    [status, headers, body]
  end

  def decode_query_params(env)
    params = Rack::Utils.parse_query(env['QUERY_STRING'])
    options = params['format'].split(',')
    process_options(options)
  end

  def process_options(options)
    bad_options = options.reject { |item| FORMATS.include?(item) }
    return { success: true, good_options: options.map { |item| Time.now.public_send(item) } } if bad_options.empty?

    { success: false, bad_options: bad_options }
  end

end
