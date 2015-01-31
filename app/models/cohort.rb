class Cohort < ActiveRecord::Base
  has_many :students
  has_many :pairs

  def shuffle(number_of_people=2)
    [].tap do |pairs|
      self.students.permutation(number_of_people) do |pair|
        pairs << pair.sort!
      end
    end.uniq!
  end

  def create_groups
    self.shuffle.each do |pair|
      # student_one = Student.find_by(name: pair[0])
      # student_two = Student.find_by(name: pair[1])
      pair = self.pairs.build(first_student_id: pair[0].id, second_student_id: pair[1].id)
      pair.save!
    end
  end

  def assign!
    pairs = self.pairs.to_a
    pairs.sort_by! do |pair|
      pair.counter
    end
    until pairs.empty?
      p pick = pairs.first
      pairs.delete_if { |pair| pair.first_student_id==(pick.first_student_id) }
      pairs.delete_if { |pair| pair.first_student_id==(pick.second_student_id) }
      pairs.delete_if { |pair| pair.second_student_id==(pick.first_student_id) }
      pairs.delete_if { |pair| pair.second_student_id==(pick.second_student_id) }
    end
  end

end
