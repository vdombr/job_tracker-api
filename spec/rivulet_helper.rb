require 'rivulet'
require 'database_cleaner/sequel'

DatabaseCleaner.strategy = :truncation

Rivulet.app.startup
