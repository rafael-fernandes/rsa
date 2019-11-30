require 'prime'
require 'digest'
require 'openssl'

require File.expand_path('../boot', __FILE__)
Dir["#{File.dirname(__FILE__)}/../lib/*.rb"].each { |file| require file }

Bundler.require

module RSACrytpoSystem
  class Application
    # $TTY_LEVEL = :info
    $TTY_LEVEL = :debug
  end
end
