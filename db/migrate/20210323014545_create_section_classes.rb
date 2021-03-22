class CreateSectionClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :section_classes do |t|

      t.timestamps
    end
    add_reference :section_classes, :study_class, foreign_key: true
    add_reference :section_classes, :subject, foreign_key: true
  end
end
