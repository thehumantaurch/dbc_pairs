class Group < ActiveRecord::Base
  belongs_to :cohort
  serialize :assignment, Array
end
