module Tasque
  module Worker

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def run!
        Tasque.reset
        begin_setup!
        begin_processing!
      end

      def setup; end

      def begin_setup!
        setup
      rescue => exception
        raise "#{exception.inspect} occured during setup"
      end
      private :begin_setup!

      def begin_processing!
        Tasque.threads = 1.times.map do
          new_processing_thread
        end
        Tasque.threads.each(&:join)
      rescue => exception
      ensure
      end
      private :begin_processing!

      def new_processing_thread
        Thread.new do
          begin
            new.process "HELLO WORLD"
          rescue => exception
            raise "#{exception.inspect} occured during processing"
          end
        end
      end
      private :new_processing_thread
    end

    def process(message); end

  end
end
