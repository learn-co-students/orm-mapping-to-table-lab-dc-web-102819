require 'bundler'
Bundler.require
require 'pry'

require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}
Student.create_table

# binding.pry