require_relative 'tasque/worker'

module Tasque
  def self.threads=(val)
    @threads = val
  end

  def self.threads
    @threads
  end
end