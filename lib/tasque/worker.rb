module Tasque
  module Worker

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def run!
        Tasque.reset
        begin_startup!
        begin_processing!
      end

      def begin_startup!
        startup
      rescue => exception
        raise "#{exception.inspect} occured during startup"
      end
      private :begin_startup!

      def startup; end

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

      def process(message); end

    end

  end
end
