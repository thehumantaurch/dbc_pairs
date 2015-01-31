class Pair < ActiveRecord::Base
  belongs_to :cohort
  belongs_to :first_student, class_name: "Student"
  belongs_to :second_student, class_name: "Student"
  has_one :counter
end
