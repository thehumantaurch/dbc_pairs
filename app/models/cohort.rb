class Cohort < ActiveRecord::Base
  has_many :students
  has_many :pairs
  has_many :groups

  def shuffle(number_of_people=2)
    students = self.students.to_a
    @odds = []
    @odds << students.pop until students.size % number_of_people != 0
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
    return {groups: picks_for_today, odds: @odds}
  end

  def create_base_group(number_of_people)
    base_group = self.shuffle(number_of_people)
    @odds.each do |odd|
      base_group.each { |bg| bg << odd }
    end
    base_group
  end

  def assign_groups(number_of_people)
    base_group = create_base_group(number_of_people)
    unless self.groups.empty?
      counter = 0
      loop_counter = 0
      until counter >= base_group.sort_by{|group| group.size}.first.size
        if base_group.all? { |group| check_uniq(self.groups, group, counter) }
          # Group.create(assignment: base_group)
          break
        else
          loop_counter += 1
          counter += 1 if loop_counter % 4 == 0
          base_group = create_base_group(number_of_people)
        end
      end
    end
   p base_group
    # group = self.groups.new
    # group.assignment = base_group
    # group.save
  end

  def check_uniq(base_group, target_group, uniq_level)
    base_group.all? { |b_group| (target_group & base_group).size >= uniq_level }
  end
end
