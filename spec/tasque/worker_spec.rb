require_relative '../spec_helper'

describe Tasque::Worker do
  class TestWorker
    include Tasque::Worker
  end

  describe '.run!' do
    it 'starts the worker' do
      TestWorker.should_receive(:begin_startup!)
      TestWorker.should_receive(:begin_processing!)

      TestWorker.run!
    end
  end

  describe '.begin_startup!' do
    it 'calls the user implemented startup method' do
      TestWorker.should_receive(:begin_startup!)

      TestWorker.run!
    end
  end

  describe '.begin_processing!' do
    it 'calls the user implemented process method' do
      TestWorker.should_receive(:new_processing_thread)

      TestWorker.send :begin_processing!
    end
  end

  describe '.new_processing_thread' do
    xit 'calls the user implemented process method' do
      TestWorker.should_receive(:process)

      TestWorker.send :new_processing_thread
    end
  end

end