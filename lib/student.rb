class Student

  attr_accessor :name, :grade
  attr_reader :id


  def initialize(name, grade, id=1)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
  # Remember, you can access your database connection anywhere in this class with DB[:conn]
    sql = <<-SQL
    CREATE TABLE students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade, id)
    VALUES (?,?,?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
 
  
end
