class Cohort < ActiveRecord::Base
  has_many :students
  has_many :pairs

  def shuffle(number_of_people=2)
    students = self.students
    [].tap do |pairs|
      students.permutation(number_of_people) do |pair|
        pairs << pair.sort!
      end
    end.uniq!
  end

  def create_groups
    self.shuffle.each do |pair|
      pair = self.pairs.build(first_student_id: pair[0].id, second_student_id: pair[1].id)
      pair.save!
    end
  end

  def assign!
    students = self.students
    odd = students.last if students.size % 2 != 0
    pairs = self.pairs.to_a
    pairs.sort_by! do |pair|
      pair.counter
    end
    picks_for_today = []
    until pairs.empty?
      pick = pairs.first
      picks_for_today << pick
      pairs.delete_if { |pair| pair.first_student_id==(pick.first_student_id) }
      pairs.delete_if { |pair| pair.first_student_id==(pick.second_student_id) }
      pairs.delete_if { |pair| pair.second_student_id==(pick.first_student_id) }
      pairs.delete_if { |pair| pair.second_student_id==(pick.second_student_id) }
      pick.increment!(:counter)
    end
    picks_for_today.collect! do |pick|
      "#{Student.find(pick.first_student_id).name}, #{Student.find(pick.second_student_id).name}"
    end
    picks_for_today.sample << ", #{odd.name}"
    p picks_for_today
  end

end
