#!/usr/bin/env ruby

require "open-uri"

@counter = 0

start = Time.now

1.upto(2).map {
  Thread.new do
    URI.open("https://httpbin.org/delay/1.6")

    @counter += 1
  end
}.each(&:join)

puts "Duration: #{Time.now - start}"