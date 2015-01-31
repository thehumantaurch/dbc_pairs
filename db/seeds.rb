cohorts = DBC.client.cohort.all

cohorts.each do |c|
  Cohort.create(name: c.name)
end

15.times do
  Student.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, cohort_id: Cohort.all.sample.id)
end
