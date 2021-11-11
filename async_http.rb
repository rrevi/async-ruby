#!/usr/bin/env ruby

require "async"
require "async/http/internet"

start = Time.now

Async do |task|
  http_client = Async::HTTP::Internet.new

  task.async do
    http_client.get("https://httpbin.org/delay/1.6")
  end

  task.async do
    http_client.get("https://httpbin.org/delay/1.6")
  end
end

puts "Duration: #{Time.now - start}"
