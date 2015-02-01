class PairsController < ApplicationController
  def index
    cohort = Cohort.find(params[:cohort_id])
    cohort.create_groups
    assignment = cohort.assign!
    @pairs = formate_groups(assignment)
    # @assignment = assignment
  end

  def formate_groups(assignment)
    pairs_array = assignment[:groups].collect { |group| [Student.find(group.first_student_id), Student.find(group.second_student_id)] }
    pairs_array.sample << assignment[:odd] if assignment[:odd]
    pairs_array
  end
end
