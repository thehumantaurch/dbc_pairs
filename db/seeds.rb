DBC::Cohort.all.each do |c|
  cohort = Cohort.create(name: c.name)
  c.students.each do |student|
    cohort.students.create(name: student.name)
  end


45.times do
  Student.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, cohort_id: rand(1..5))
end

5.times do
Cohort.create(name: Faker::Hacker.noun)
end
# p cohorts
# cohorts.each do |name|
#   Cohort.create(name: name)
# end

# cohorts.each do |c|
#   students = c.students
# end
