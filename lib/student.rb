#  Student
#  responds to a getter for :id
#  does not provide a setter for :id
require 'pry'
class Student
  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  #  initialized with a name and a grade
    #  the name attribute can be accessed
    #  the grade attribute can be accessed
  def initialize(name, grade, id=nil)
     @name = name
     @grade = grade
     @id = id
   end
  #  .create_table
  #  creates the students table in the database
   def self.create_table
     sql = <<-SQL
         CREATE TABLE IF NOT EXISTS students (
         id INTEGER PRIMARY KEY,
         name TEXT,
         grade INTEGER
         )
       SQL
     DB[:conn].execute(sql)
   end
  #  .drop_table
  #  drops the students table from the database
   def self.drop_table
     sql = <<-SQL
         DROP TABLE students
       SQL
     DB[:conn].execute(sql)
   end
#  #save
# saves an instance of the Student class to the database
   def save
     sql = <<-SQL
         INSERT INTO students (name, grade)
         VALUES (?, ?)
       SQL
     DB[:conn].execute(sql, self.name, self.grade)
     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
   end
  #   .create
    # takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database
    # returns the new object that it instantiated

   def self.create(name:, grade:)
     student = Student.new(name, grade)
     student.save
     student
   end
 end