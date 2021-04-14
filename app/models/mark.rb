class Mark < ApplicationRecord
  belongs_to :school
  has_many :tests, dependent: :destroy
end
