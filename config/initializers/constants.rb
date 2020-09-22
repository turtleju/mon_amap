# frozen_string_literal: true

require 'yaml'

dir = Rails.root.join('config', 'constants', '*.yml')
Dir.glob(dir) do |file|
  basename    = File.basename(file, '.yml')
  data        = YAML.load_file(file)
  const_name  = basename.upcase

  Object.const_set(const_name, data)
  puts "#{const_name} declared in #{__FILE__}" if ENV['DEBUG_ALL']
end
