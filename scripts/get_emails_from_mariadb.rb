#!/usr/bin/env ruby

require 'mysql2'

client = Mysql2::Client.new(
  username: ENV['DB_USERNAME'],
  password: ENV['DB_PASSWORD'],
  host: ENV['DB_HOST'],
  port: ENV['DB_PORT'],
  database: ENV['DB_NAME']
)

### INSERT SAMPLE DATA
# client.query "INSERT INTO users (email) VALUES (\"hello@example.com\")", async: true

### DELETE SPECIFIC DATA
# statement = client.prepare "DELETE FROM users WHERE email = ?"
# statement.execute('delete.this@example.com')

### PRINT ALL DATA
result = client.query "SELECT * FROM users"
result.each do |row|
  puts row["email"]
end
