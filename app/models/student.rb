class Student < ActiveRecord::Base
  belongs_to :cohort
  has_many :pairs

  def name
    "#{self.last_name} #{self.first_name}"
  end
end
