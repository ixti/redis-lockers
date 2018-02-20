# frozen_string_literal: true

require "redis/lockers/lock"

RSpec.describe Redis::Lockers::Lock do
  let(:alpha) { described_class.new(:xxx, :ttl => 123_456) }
  let(:omega) { described_class.new(:xxx, :ttl => 123_456) }

  describe "#acquire" do
    it "returns true if lock was acquired" do
      expect(alpha.acquire(REDIS)).to be true
    end

    it "returns false if lock is held by somebody else" do
      omega.acquire(REDIS)
      expect(alpha.acquire(REDIS)).to be false
    end

    it "returns false if lock lease acquire took longer than allowed ttl" do
      expect(Concurrent).to receive(:monotonic_time).and_return(0, 456_789)
      expect(alpha.acquire(REDIS)).to be false
    end
  end

  describe "#release" do
    before { alpha.acquire(REDIS) }

    it "returns releases owned lease" do
      alpha.release(REDIS)
      expect(omega.acquire(REDIS)).to be true
    end

    it "returns does not releases lease owned by other lock" do
      omega.release(REDIS)
      expect(omega.acquire(REDIS)).to be false
    end
  end
end
