local key = KEYS[1]
local nonce = ARGV[1]
local ttl = ARGV[2]

if redis.call("EXISTS", key) == 0 or redis.call("GET", key) == nonce then
  return redis.call("SET", key, nonce, "PX", ttl)
end
