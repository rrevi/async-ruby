#!/usr/bin/env ruby

require "open-uri"

start = Time.now

URI.open("https://httpbin.org/delay/1.6")
URI.open("https://httpbin.org/delay/1.6")

puts "Duration: #{Time.now - start}"