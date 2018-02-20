# frozen_string_literal: true

require "redis/lockers/version"
require "redis/lockers/lock"

# @see https://github.com/redis/redis-rb
class Redis
  # Distributed locks with Redis.
  module Lockers
    # Creates new lock and yields control if it was successfully acquired.
    # Ensures lock is released after execution of the block.
    #
    # @example
    #
    #     REDIS = Redis.new
    #     Redis::Lockers.acquire(REDIS, :resource_name, :ttl => 60_000) do
    #       # lock was successfully acquired - we're good to run our code
    #     end
    #
    # @yield [] Executes given block if lock was acquired.
    # @return [Object] result of the last expression in the block
    def self.acquire(redis, *args, **kwargs)
      lock = Lock.new(*args, **kwargs)
      yield if lock.acquire(redis)
    ensure
      lock&.release(redis)
    end
  end
end
