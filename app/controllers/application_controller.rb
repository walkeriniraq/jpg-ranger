class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :redis_context_filter

  def redis_context_filter
    DbConnectionPool.instance.with_connection do |redis|
      @redis_connection = redis
      yield
      @redis_connection = nil  # While this shouldn't be neccesary, it's best to make sure
    end
  end

  def redis
    @redis_connection
  end

  def render_json(hash)
    render json: hash
  end

end
