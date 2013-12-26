require 'yaml'
# tasque:
#   threads: 3
# stomp:
#   subscription: /queue/example
#   connection:
#     hosts:
#     - login: admin
#       passcode: admin
#       host: localhost
#       port: 61613
#     reliable: true
#     max_reconnect_attempts: 0
#     initial_reconnect_delay: 1
#     connect_timeout: 3
#     randomize: true
#     parse_timeout: 10
module Tasque
  class Configuration
    include Singleton
    attr_accessor :threads, :verbose, :stomp

    def self.default_logger
      logger = Logger.new(STDOUT)
      logger.progname = 'tasque'
      logger
    end

    def self.defaults
      @defaults ||= {
        :threads => 1,
        :verbose => true
      }
    end

    def initialize
      self.class.defaults.each_pair { |k, v| send("#{k}=", v) }
    end

    def from_file(filename)
      hash = load_file(filename)
      merge!(hash)
    end

    def from_options(options)
      merge!({
        threads: options[:threads]
        verbose: options[:verbose]
      })
    end

    def load_file(filename)
      YAML.load_file(filename)
    end

    def merge!(hash)
      hash.each_pair { |k, v| send("#{k}=", v) }
    end
  end
end
