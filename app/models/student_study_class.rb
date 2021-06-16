class StudentStudyClass < ApplicationRecord
  belongs_to :student
  belongs_to :study_class 
end
