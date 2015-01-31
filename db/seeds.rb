DBC::Cohort.all.each do |c|
  cohort = Cohort.create(name: c.name)
  c.students.each do |student|
    cohort.students.create(name: student.name)
  end
end
# p cohorts
# cohorts.each do |name|
#   Cohort.create(name: name)
# end

# cohorts.each do |c|
#   students = c.students
# end
