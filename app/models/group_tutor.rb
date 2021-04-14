class GroupTutor < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  has_many :assigned_groups, as: :groupable, dependent: :nullify
  has_many :student_group_tutors, dependent: :destroy
  has_many :students, through: :student_group_tutors
end
