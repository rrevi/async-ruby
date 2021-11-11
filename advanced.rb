#!/usr/bin/env ruby

require "async"
require "open-uri"
require "httparty"
require "redis"
require "net/ssh"
require "sequel"

DB = Sequel.postgres
Sequel.extension(:fiber_concurrency)
start = Time.now

Async do |task|
  task.async do
    URI.open("https://httpbin.org/delay/1.6")
  end

  task.async do
    HTTParty.get("https://httpbin.org/delay/1.6")
  end

  task.async do
    Redis.new.blpop("abc123", 2)
  end

  task.async do
    Net::SSH.start("192.168.1.22").exec!("sleep 1")
  end

  task.async do
    DB.run("SELECT pg_sleep(2)")
  end

  task.async do
    sleep 2
  end

  task.async do
    `sleep 2`
  end
end

puts "Duration: #{Time.now - start}"