class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable
  has_many :user_schools

  enum type: [:Manager, :SchoolAdmin, :Teacher, :Student]

  scope :teachers, ->{ where type: :Teacher }
  scope :students, ->{ where type: :Student }
  scope :school_admins, ->{ where type: :SchoolAdmin }
  scope :managers, ->{ where type: :Manager }
end
