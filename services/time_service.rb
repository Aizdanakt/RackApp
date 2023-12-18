class TimeService
  Response = Struct.new(:valid_options, :invalid_options, :success?)

  FORMATS = %w[year month day hour min sec].freeze

  def call(options)
    create_response(options)
  end

  private

  def success?(options)
    options.all? { |item| FORMATS.include?(item) }
  end

  def create_response(options)
    Response.new(valid_options(options), invalid_options(options), success?(options))
  end

  def valid_options(options)
    return unless success?(options)

    options.map { |item| Time.now.public_send(item) }.join('-')
  end

  def invalid_options(options)
    options.reject { |item| FORMATS.include?(item) }
  end
end
