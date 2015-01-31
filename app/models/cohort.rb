class Cohort < ActiveRecord::Base
  has_many :students
  has_many :pairs

  def shuffle(number_of_people=2)
    students = self.students.to_a
    @odd = students.pop if students.size % 2 != 0
    [].tap do |pairs|
      students.permutation(number_of_people) do |pair|
        pairs << pair.sort!
      end
    end.uniq!
  end

  def create_groups
    self.shuffle.each do |pair|
      pair = self.pairs.find_or_initialize_by(first_student_id: pair[0].id, second_student_id: pair[1].id)
      pair.save!
      Counter.create(pair: pair)
    end
  end

  def assign!
    students = self.students
    pairs = self.pairs.to_a
    pairs.sort_by! do |pair|
      pair.counter.count
    end
    picks_for_today = []
    until pairs.empty?
      pick = pairs.first
      picks_for_today << pick
      pairs.delete_if { |pair| pair.first_student_id==(pick.first_student_id) }
      pairs.delete_if { |pair| pair.first_student_id==(pick.second_student_id) }
      pairs.delete_if { |pair| pair.second_student_id==(pick.first_student_id) }
      pairs.delete_if { |pair| pair.second_student_id==(pick.second_student_id) }
      pick.counter.increment!(:count)
    end
    return {groups: picks_for_today, odd: @odd}
  end

end
