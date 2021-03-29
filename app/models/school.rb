class School < ApplicationRecord
  has_many :user_schools, dependent: :destroy
  has_many :users, through: :user_schools
  has_many :semesters, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :levels, dependent: :destroy

  delegate :teachers, :students, :school_admins, to: :users
end
