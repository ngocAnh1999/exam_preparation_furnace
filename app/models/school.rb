class School < ApplicationRecord
  has_many :user_schools, dependent: :destroy
  has_many :users, through: :user_schools

  delegate :teachers, :students, :school_admins, to: :users
end
