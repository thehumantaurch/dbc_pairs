class PairsController < ApplicationController
  def index
    cohort = Cohort.find(params[:cohort_id])
    cohort.create_groups
    assignment = cohort.assign!
    @groups = formate_groups(assignment)
  end

  def formate_groups(assignment)
    group_name_array = assignment[:groups].collect { |group| "#{Student.find(group.first_student_id).name}, #{Student.find(group.second_student_id).name}" }
    group_name_array.sample << ", #{assignment[:odd].name}" if assignment[:odd]
    group_name_array
  end
end
