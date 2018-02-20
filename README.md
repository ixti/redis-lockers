# Redis::Lockers

[![Build Status](https://travis-ci.org/ixti/redis-lockers.svg?branch=master)](https://travis-ci.org/ixti/redis-lockers)
[![codecov](https://codecov.io/gh/ixti/redis-lockers/branch/master/graph/badge.svg)](https://codecov.io/gh/ixti/redis-lockers)
[![Maintainability](https://api.codeclimate.com/v1/badges/5c7c97ef80e7cff43325/maintainability)](https://codeclimate.com/github/ixti/redis-lockers/maintainability)
[![Inline docs](http://inch-ci.org/github/ixti/redis-lockers.svg?branch=master)](http://inch-ci.org/github/ixti/redis-lockers)

Yet another Redis-based lock manager.

Simplified implementation of Redlock (distributed lock manger by antirez).
Right now it works with single Redis node only.

## Why another implementation?

I wanted to have simplified implementation that is simple to maintain and work
with. The most important part I dislike in existing solutions is that they all
create their own connections, which I find a bit inconvinient.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis-lockers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-lockers


## Usage

``` ruby
REDIS = Redis.new
Redis::Lockers.acquire(REDIS, :resource_name, :ttl => 60_000) do
  # lock was successfully acquired - we're good to run our code
end
```


## Supported Ruby Versions

This library aims to support and is [tested against][travis-ci] the following
Ruby and Redis client versions:

* Ruby
  * 2.3.x
  * 2.4.x
  * 2.5.x

* [redis-rb](https://github.com/redis/redis-rb)
  * 4.x

* [redis-namespace](https://github.com/resque/redis-namespace)
  * 1.6


If something doesn't work on one of these versions, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby versions,
however support will only be provided for the versions listed above.

If you would like this library to support another Ruby version or
implementation, you may volunteer to be a maintainer. Being a maintainer
entails making sure all tests run and pass on that implementation. When
something breaks on your implementation, you will be responsible for providing
patches in a timely fashion. If critical issues for a particular implementation
exist at the time of a major release, support for that Ruby version may be
dropped.


## Development

After checking out the repo, run `bundle install` to install dependencies.
Then, run `bundle exec rake spec` to run the tests with ruby-rb client.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org][].


## Contributing

* Fork redis-lockers on GitHub
* Make your changes
* Ensure all tests pass (`bundle exec rake`)
* Send a pull request
* If we like them we'll merge them
* If we've accepted a patch, feel free to ask for commit access!


## See Also

- [Redlock specification](https://redis.io/topics/distlock)
- [Redlock Ruby implementation](https://github.com/leandromoreira/redlock-rb)


## Copyright

Copyright (c) 2018 Alexey Zapparov, SensorTower Inc.<br>
See [LICENSE.md][] for further details.


[travis.ci]: http://travis-ci.org/ixti/redis-lockers
[rubygems.org]: https://rubygems.org
[LICENSE.md]: https://github.com/ixti/redis-lockers/blob/master/LICENSE.txt
