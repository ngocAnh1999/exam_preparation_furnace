class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  USER_PARAMS = %i[username first_name last_name type email phone password password_confirmation remember_me].freeze

  has_many :user_schools, dependent: :destroy
  has_many :schools, through: :user_schools
  has_many :marks, through: :schools

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

  enum type: [:Manager, :SchoolAdmin, :Teacher, :Student]

  scope :teachers, ->{ where type: :Teacher }
  scope :students, ->{ where type: :Student }
  scope :school_admins, ->{ where type: :SchoolAdmin }
  scope :managers, ->{ where type: :Manager }

  def full_name
    [first_name, last_name].join(" ")
  end
end
