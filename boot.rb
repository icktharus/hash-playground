APP_ENV = ENV.fetch('ENV', 'development') unless defined?(APP_ENV)

[
 'base_hash.rb',
 'linear_probe_hash.rb',
 'quadratic_probe_hash.rb',
 'double_hash.rb',
 'separate_chaining_hash.rb',
].each do |file|

  Dir[File.dirname(__FILE__) + "/lib/#{file}"].each {|file| require file}

end
