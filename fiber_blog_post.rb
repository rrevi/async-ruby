#!/usr/bin/env ruby

# asynchronous - using blocking Fiber primitive
def nap
    # puts "you now have to wait, while I nap..."
    sleep 3
    # puts "...and now I'm awake, you can move along."
end

puts "blocking asynchronous execution, using the Fiber primitive"
fiber = Fiber.new do
    nap
    nap
end

fiber.resume
puts "blocking fibers are so boring."

# asynchronous - non-blocking fiber using Async gem
require 'async'

def nap_async
    Async do |task|
        # puts "you now have to wait, while I nap..."
        sleep 3
        # puts "...and now I'm awake, you can move along."
    end
end

puts "non-blocking asynchronous execution, using the Async gem"

Async do
    nap_async
    nap_async
end

puts "non-blocking fibers are so much fun!"

# benchmark
require 'benchmark'

Benchmark.bm do |x|
  # sequential version
  x.report('sequential'){ 3.times{ nap } }

  # blocking fiber version
  x.report('blocking fiber'){
    3.times.map do
        fiber = Fiber.new do
            nap
        end

        fiber.resume
    end
  }

  # non-blocking fiber version
  x.report('non-blocking fiber'){
    Async do 
      3.times.map do
        Async do
            nap_async
        end
      end
    end
  }
end