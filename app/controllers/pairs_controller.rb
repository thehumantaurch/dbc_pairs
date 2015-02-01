class PairsController < ApplicationController
  def index
    cohort = Cohort.find(params[:cohort_id])
    cohort.create_groups
    assignment = cohort.assign!

    @pairs = formate_groups(assignment)

    @groups = formate_groups(assignment)
    render partial: "pairs/list"
    @groups_array = multi_formate_groups(assignment)
  end

  def formate_groups(assignment)
    pairs_array = assignment[:groups].collect { |group| [Student.find(group.first_student_id), Student.find(group.second_student_id)] }
    pairs_array.sample << assignment[:odd] if assignment[:odd]
    pairs_array
  end

  def multi_formate_groups(assignment)
    groups_array = []
    assignment[:groups].each_with_index do |group, index|
      next if index.odd?
      groups_array << [group, assignment[:groups][index+1]]
    end
    groups_array.sample << assignment[:odd] if assignment[:odd]
    groups_array.map! { |group| group.flatten }
    groups_array.map! {|group| [Student.find(group[0].first_student_id), Student.find(group[0].second_student_id), Student.find(group[1].first_student_id), Student.find(group[1].second_student_id)]}
    # group_name_array = assignment[:groups].collect { |group| "#{Student.find(group.first_student_id).name}, #{Student.find(group.second_student_id).name}" }
    # group_name_array.sample << ", #{assignment[:odd].name}" if assignment[:odd]
    # group_name_array
  end
end
