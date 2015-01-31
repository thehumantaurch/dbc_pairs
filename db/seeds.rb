DBC::Cohort.all.each do |c|
  cohort = Cohort.create(name: c.name)
  c.students.each do |student|
    cohort.students.create(name: student.name)
  end
end
