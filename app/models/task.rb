class Task < ApplicationRecord
  belongs_to :student
  belongs_to :assigned_group
end
