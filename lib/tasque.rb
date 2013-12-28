require_relative 'tasque/worker'

module Tasque

  def self.reset
    @messages_in = 0
    @messages_out = 0
    @semaphore_messages_in = Mutex.new
    @semaphore_messages_out = Mutex.new
  end

  def self.increment_messages_push
    @semaphore_messages_push.synchronize do
      @messages_push += 1
    end
  end

  def self.increment_messages_pop
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
    queue << message
  end

  def self.dequeue
    queue.pop
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

end