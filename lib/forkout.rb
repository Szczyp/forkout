require 'rinda/tuplespace'
require 'rinda/ring'

module Forkout
  extend self

  def start
    @service = DRb.start_service

    @tuple_space = Rinda::TupleSpace.new 1

    @server = Rinda::RingServer.new @tuple_space

    @counter = 0

    @started = true
  end

  def run items, procs, &block
    start unless @started

    @counter += 1

    input = "#{$$}_forkout_input_#{@counter}"
    output = "#{$$}_forkout_output_#{@counter}"

    pids = []

    procs.times do
      pid = fork
      unless pid
        Signal.trap('QUIT') { exit! }

        DRb.start_service

        tuple_space = Rinda::RingFinger.primary

        while true
          item = tuple_space.take([input, nil])[1]
          result = block.call item
          tuple_space.write [output, result]
        end
      else
        pids << pid
      end
    end

    results = []

    items.each do |item|
      @tuple_space.write [input, item]
    end
    
    while results.length != items.length
      result = @tuple_space.take([output, nil])[1]
      results << result
    end

    pids.each do |pid|
      Process.kill 'QUIT', pid
      Process.wait pid
    end

    return results
  end
end

module Enumerable
  
  def forkout procs = 5, &block
    if self === Array
      items = self
    else
      begin
        items = self.to_a
      rescue NoMethodError => e
        raise NoMethodError, "Unable to coerce #{self.inspect} to an Array type."
      end
    end

    Forkout.run items, procs, &block
  end
end
