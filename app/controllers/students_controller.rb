class StudentsController < ApplicationController

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @pairs = Pair.where(first_student_id: @student.id).order(updated_at: :asc)
  end

end
