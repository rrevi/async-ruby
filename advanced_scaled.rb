#!/usr/bin/env ruby

require "async"
require "async/http/internet"
require "redis"
require "sequel"

DB = Sequel.postgres(max_connections: 100)
Sequel.extension(:fiber_concurrency)
# Warming up redis clients
redis_clients = 1.upto(100).map { Redis.new.tap(&:ping) }

start = Time.now

Async do |task|
  http_client = Async::HTTP::Internet.new

  100.times do |i|
    task.async do
      http_client.get("https://httpbin.org/delay/1.6")
    end

    task.async do
      redis_clients[i].blpop("abc123", 2)
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
end

puts "Duration: #{Time.now - start}s"