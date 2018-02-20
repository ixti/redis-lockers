# frozen_string_literal: true

require "redis/lockers"

RSpec.describe Redis::Lockers do
  describe ".acquire" do
    it "yields control when lock was acquired" do
      expect { |b| described_class.acquire(REDIS, :xxx, :ttl => 7000, &b) }.
        to yield_control
    end

    it "releases lock lease even if block failed" do
      begin
        described_class.acquire(REDIS, :xxx, :ttl => 123_456) { raise "boom" }
      rescue
        nil # do nothing
      end

      expect { |b| described_class.acquire(REDIS, :xxx, :ttl => 7000, &b) }.
        to yield_control
    end

    it "does not yields control if lock can't be acquired" do
      Redis::Lockers::Lock.new(:xxx, :ttl => 123_456).acquire(REDIS)
      expect { |b| described_class.acquire(REDIS, :xxx, :ttl => 7000, &b) }.
        not_to yield_control
    end
  end
end
