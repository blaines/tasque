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
      rescue => exception
        Tasque.logger.info "exception #{exception}"
      ensure
        threads_alive = Tasque.threads.select {|t| t.alive?}
        # sleep 1
        # puts threads_alive
        loop do
          sleep 0.1
          threads_alive.each {|t| puts t.inspect if t.alive?}
          threads_alive.each {|t| puts t.inspect if t.alive?}
          # threads_alive.each {|t| t.join if t.alive?}
        end
      end
      private :begin_processing!

      def new_processing_thread
        Thread.new do
          begin
            while message = Tasque.dequeue
              begin
                new.process message
              rescue => exception
                raise "#{exception.inspect} occured while processing a message"
              end
            end
          rescue => exception
            Tasque.logger.error "#{exception.inspect}"
          ensure
            Thread.exit
          end
        end
      rescue => exception
        Tasque.logger.error "#{exception.inspect}"
      end
      private :new_processing_thread
    end

    def process(message); end

  end
end
