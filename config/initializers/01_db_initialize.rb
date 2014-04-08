require 'redis'
require 'singleton'

class Redis
  def value(name, opts = {})
    Redis::Value.new(name, self, opts)
  end

  def list(name, opts = {})
    Redis::List.new(name, self, opts)
  end

  def redis_hash(name, opts = {})
    Redis::HashKey.new(name, self, opts)
  end

  def redis_set(name, opts = {})
    Redis::Set.new(name, self, opts)
  end

  def sorted_set(name, opts = {})
    Redis::SortedSet.new(name, self, opts)
  end

  def lock(name, opts = {})
    Redis::Lock.new(name, self, opts)
  end

  ###
  # Custom initializers for jpg-ranger
  ###

end

class DbConnectionPool
  include Singleton

  def initialize
    @connection_hash = {}
  end

  def with_connection
    @pool ||= ConnectionPool.new(:size => 20, :timeout => 5) { Redis.new(@connection_hash) }
    @pool.with do |conn|
      yield conn
    end
  end

  # due to the way that the connection pool library works, this is likely to be much slower than
  # using the with_connection method above
  def connection
    @slow_pool ||= ConnectionPool::Wrapper.new(:size => 1, :timeout => 5) { Redis.new(@connection_hash) }
  end

  def configure(connection_hash)
    @connection_hash = connection_hash
  end

end

DbConnectionPool.instance.configure(Rails.application.config.db)
