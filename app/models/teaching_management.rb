class TeachingManagement < ApplicationRecord
  belongs_to :teacher
  belongs_to :study_class
end
