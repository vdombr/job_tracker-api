Rivulet.configure do |config|
  config.app.name = :job_tracker

  config.database.dsn = ENV.fetch('DATABASE_URL', 'postgres://rivulet:rivulet@db:5432/job_tracker_development')

  # config.sendfile.enabled   = true
  # config.sendfile.variation = 'x-accel-redirect'
  # config.sendfile.mappings   = [['/var/www/', '/files/']]

  config.logger.level = :info
end
