class TimeService

  FORMATS = %w[year month day hour min sec].freeze

  def valid_options(options)
    options.map { |item| Time.now.public_send(item) }.join('-')
  end

  def formats
    FORMATS
  end

  def invalid_options(options)
    options.reject { |item| FORMATS.include?(item) }
  end
end
