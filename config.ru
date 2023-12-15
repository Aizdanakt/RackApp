# frozen_string_literal: true

require_relative 'middleware/time_handler'
require_relative 'app'

use TimeHandler
run App.new
