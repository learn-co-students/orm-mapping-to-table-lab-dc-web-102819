require 'pry'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_accessor :name, :grade
  attr_reader :id

  @@all = []

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
    @@all << self
  end

  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
      SQL

      DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
      SQL

      DB[:conn].execute(sql)
  end
  
  def self.create(student_hash)
    new_student = Student.new(student_hash[:name], student_hash[:grade])
    new_student.save
    new_student
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    sql2 = <<-SQL
      SELECT id FROM students
      ORDER BY id DESC LIMIT 1;
    SQL

    new_id = DB[:conn].execute(sql2)[0][0]
#    binding.pry
    @id = new_id
  end
  
end
