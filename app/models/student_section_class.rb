class StudentSectionClass < ApplicationRecord
  belongs_to :student
  belongs_to :section_class
end
