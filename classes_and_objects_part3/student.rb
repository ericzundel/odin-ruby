# https://launchschool.com/books/oo_ruby/read/inheritance#exercises
#
class Student
  attr_reader :name
  attr_writer :grade

  def initialize(name)
    @name = name
    @grade = 0
  end

  def grade_better_than?(other)
    other.grade < @grade
  end

  protected

  attr_reader :grade
end
