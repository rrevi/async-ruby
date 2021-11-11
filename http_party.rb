#!/usr/bin/env ruby

require "async"
require "open-uri"
require "httparty"

start = Time.now

Async do |task|
  task.async do
    URI.open("https://httpbin.org/delay/1.6")
  end

  task.async do
    HTTParty.get("https://httpbin.org/delay/1.6")
  end
end

puts "Duration: #{Time.now - start}"