require_relative 'tasque/worker'
require_relative 'tasque/configuration'

module Tasque

  def self.reset
    @messages_push = 0
    @messages_pop = 0
    @semaphore_messages_push = Mutex.new
    @semaphore_messages_pop = Mutex.new
  end

  def self.increment_messages_push
    Tasque.logger.info "I"
    @semaphore_messages_push.synchronize do
      @messages_push += 1
    end
  end

  def self.increment_messages_pop
    Tasque.logger.info "O"
    @semaphore_messages_pop.synchronize do
      @messages_pop += 1
    end
  end

  def self.config
    Configuration.instance
  end

  def self.configure
    yield config
  end

  def self.logger
    config.logger
  end

  def self.queue
    @queue ||= Queue.new
  end

  def self.enqueue(message)
    increment_messages_push
    queue << message
  end

  def self.dequeue
    message = queue.pop
    increment_messages_pop
    message
  end

  def started_at
    @started_at ||= Time.now.to_f
  end

  def ended_at
    @ended_at ||= Time.now.to_f
  end

  def self.threads=(val)
    @threads = val
  end

  def self.threads
    @threads
  end

  def self.stop?
    @messages_push == @messages_pop
  end

end