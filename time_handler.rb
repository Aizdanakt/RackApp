require_relative 'param_parser'

class TimeHandler

  FORMATS = %w[year month day hour min sec].freeze

  def initialize(env)
    @params = env
  end

  def call
    @options = ParamParser.new(@params).call
  end

  def valid?
    @options.all? { |item| FORMATS.include?(item) }
  end

  def valid_request?
    @params['REQUEST_METHOD'] == 'GET' && @params['PATH_INFO'] == '/time'
  end

  def valid_options
    @options.map { |item| Time.now.public_send(item) }.join('-')
  end

  def invalid_options
    @options.reject { |item| FORMATS.include?(item) }
  end
end
