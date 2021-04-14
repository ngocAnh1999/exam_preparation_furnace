class AddLevelToStudyClasses < ActiveRecord::Migration[6.0]
  def change
    add_reference :study_classes, :level
  end
end
