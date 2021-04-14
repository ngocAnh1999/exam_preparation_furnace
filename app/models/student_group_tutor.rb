class StudentGroupTutor < ApplicationRecord
  belongs_to :student
  belongs_to :group_tutor
end
