class SchoolAdmin < User
  has_many :user_schools, dependent: :destroy
end
