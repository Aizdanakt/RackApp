class ParamParser

  def initialize(params)
    @params = params
  end

  def call
    params = Rack::Utils.parse_query(@params['QUERY_STRING'])
    params['format'].split(',')
  end
end
