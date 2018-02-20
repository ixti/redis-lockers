# frozen_string_literal: true

require "securerandom"

require "concurrent/utility/monotonic_time"
require "redis/prescription"

class Redis
  module Lockers
    # Single lock instance.
    class Lock
      LOCK_SCRIPT = Redis::Prescription.read("#{__dir__}/scripts/lock.lua")
      private_constant :LOCK_SCRIPT

      UNLOCK_SCRIPT = Redis::Prescription.read("#{__dir__}/scripts/unlock.lua")
      private_constant :UNLOCK_SCRIPT

      # Create a new Lock instance.
      # @param key [#to_s] Resource name
      # @param ttl [#to_i] TTL in milliseconds
      def initialize(key, ttl:)
        @key   = key.to_s
        @ttl   = ttl.to_i
        @drift = @ttl * 0.01 + 2
        @nonce = SecureRandom.uuid
      end

      # Attempts to acquire lease.
      #
      # @param redis [Redis] Redis client
      # @return [Boolean] whenever lock was acquired or not.
      def acquire(redis)
        deadline = timestamp + @ttl + @drift
        success  = LOCK_SCRIPT.eval(redis, {
          :keys => [@key],
          :argv => [@nonce, @ttl]
        })

        success && timestamp < deadline || false
      end

      # Release acquired lease.
      #
      # @param redis [Redis] Redis client
      # @return [void]
      def release(redis)
        UNLOCK_SCRIPT.eval(redis, :keys => [@key], :argv => [@nonce])
      end

      private

      # Returns monotonic timestamp.
      # @return [Float]
      def timestamp
        Concurrent.monotonic_time
      end
    end
  end
end
