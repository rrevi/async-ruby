#!/usr/bin/env ruby

require 'async'
require 'benchmark'

Benchmark.bm do |x|
  # sequential version
  x.report('sequential'){ 48.times{ sleep 1 } }

  # partial asynchronous version
  x.report('partial asynchronous'){
    48.times.map do
      Async do
        sleep 1
      end
    end
  }

  # full asynchronous version
  x.report('full asynchronous'){
    Async do 
      48.times.map do
        Async do
          sleep 1
        end
      end
    end
  }

  # parallel version
  x.report('parallel'){
    48.times.map do
      Ractor.new { sleep 1 }
    end.each(&:take)
  }
end