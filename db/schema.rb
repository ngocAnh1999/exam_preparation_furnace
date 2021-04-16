# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_16_013521) do

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.boolean "is_correct"
    t.string "content_image"
    t.integer "position"
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "assigned_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "published_at"
    t.string "groupable_type", null: false
    t.bigint "groupable_id", null: false
    t.bigint "test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["groupable_type", "groupable_id"], name: "index_assigned_groups_on_groupable_type_and_groupable_id"
    t.index ["test_id"], name: "index_assigned_groups_on_test_id"
  end

  create_table "chapters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "level_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["level_id"], name: "index_chapters_on_level_id"
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "ckeditor_assets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "draft_tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.json "questions"
    t.integer "difficulty"
    t.string "description"
    t.datetime "start_time"
    t.datetime "due_time"
    t.integer "doing_time"
    t.integer "shuffle_count", default: 1, null: false
    t.boolean "unlimited_flag", default: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["teacher_id"], name: "index_draft_tests_on_teacher_id"
  end

  create_table "group_tutors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "teacher_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_group_tutors_on_subject_id"
    t.index ["teacher_id"], name: "index_group_tutors_on_teacher_id"
  end

  create_table "levels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "school_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_levels_on_school_id"
  end

  create_table "marks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "rate", precision: 5, scale: 2, null: false
    t.bigint "school_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_marks_on_school_id"
  end

  create_table "question_tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "test_id", null: false
    t.float "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_question_tests_on_question_id"
    t.index ["test_id"], name: "index_question_tests_on_test_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content", null: false
    t.string "content_image"
    t.integer "difficulty"
    t.string "suggestion"
    t.integer "question_type"
    t.integer "databank_type"
    t.bigint "teacher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["teacher_id"], name: "index_questions_on_teacher_id"
  end

  create_table "schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "section_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "study_class_id"
    t.bigint "subject_id"
    t.index ["study_class_id"], name: "index_section_classes_on_study_class_id"
    t.index ["subject_id"], name: "index_section_classes_on_subject_id"
  end

  create_table "semesters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id"
    t.index ["school_id"], name: "index_semesters_on_school_id"
  end

  create_table "student_group_tutors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "group_tutor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_tutor_id"], name: "index_student_group_tutors_on_group_tutor_id"
    t.index ["student_id"], name: "index_student_group_tutors_on_student_id"
  end

  create_table "student_section_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "section_class_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_class_id"], name: "index_student_section_classes_on_section_class_id"
    t.index ["student_id"], name: "index_student_section_classes_on_student_id"
  end

  create_table "student_study_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "study_class_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_student_study_classes_on_student_id"
    t.index ["study_class_id"], name: "index_student_study_classes_on_study_class_id"
  end

  create_table "study_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "semester_id"
    t.bigint "level_id"
    t.index ["level_id"], name: "index_study_classes_on_level_id"
    t.index ["semester_id"], name: "index_study_classes_on_semester_id"
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id"
    t.index ["name"], name: "index_subjects_on_name"
    t.index ["school_id"], name: "index_subjects_on_school_id"
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "assigned_group_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.float "score"
    t.json "answers"
    t.integer "task_status"
    t.string "teacher_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assigned_group_id"], name: "index_tasks_on_assigned_group_id"
    t.index ["student_id"], name: "index_tasks_on_student_id"
  end

  create_table "teacher_section_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "section_class_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_class_id"], name: "index_teacher_section_classes_on_section_class_id"
    t.index ["teacher_id"], name: "index_teacher_section_classes_on_teacher_id"
  end

  create_table "teacher_shared_tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["teacher_id"], name: "index_teacher_shared_tests_on_teacher_id"
    t.index ["test_id"], name: "index_teacher_shared_tests_on_test_id"
  end

  create_table "teaching_managements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "study_class_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["study_class_id"], name: "index_teaching_managements_on_study_class_id"
    t.index ["teacher_id"], name: "index_teaching_managements_on_teacher_id"
  end

  create_table "tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "start_time"
    t.datetime "due_time"
    t.integer "doing_time"
    t.integer "shuffle_count", default: 1, null: false
    t.boolean "unlimited_flag", default: false
    t.integer "difficulty"
    t.integer "shared_status", default: 0
    t.string "link_share"
    t.bigint "teacher_id", null: false
    t.bigint "chapter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "mark_id"
    t.index ["chapter_id"], name: "index_tests_on_chapter_id"
    t.index ["link_share"], name: "index_tests_on_link_share"
    t.index ["mark_id"], name: "index_tests_on_mark_id"
    t.index ["teacher_id"], name: "index_tests_on_teacher_id"
  end

  create_table "user_schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "school_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_user_schools_on_school_id"
    t.index ["user_id"], name: "index_user_schools_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "type", null: false, comment: "User role"
    t.string "email", null: false
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "draft_tests", "users", column: "teacher_id"
  add_foreign_key "group_tutors", "subjects"
  add_foreign_key "group_tutors", "users", column: "teacher_id"
  add_foreign_key "levels", "schools"
  add_foreign_key "marks", "schools"
  add_foreign_key "question_tests", "questions"
  add_foreign_key "question_tests", "tests"
  add_foreign_key "questions", "users", column: "teacher_id"
  add_foreign_key "section_classes", "study_classes"
  add_foreign_key "section_classes", "subjects"
  add_foreign_key "semesters", "schools"
  add_foreign_key "student_group_tutors", "group_tutors"
  add_foreign_key "student_group_tutors", "users", column: "student_id"
  add_foreign_key "student_section_classes", "section_classes"
  add_foreign_key "student_section_classes", "users", column: "student_id"
  add_foreign_key "student_study_classes", "study_classes"
  add_foreign_key "student_study_classes", "users", column: "student_id"
  add_foreign_key "study_classes", "semesters"
  add_foreign_key "subjects", "schools"
  add_foreign_key "teacher_section_classes", "section_classes"
  add_foreign_key "teacher_section_classes", "users", column: "teacher_id"
  add_foreign_key "teaching_managements", "study_classes"
  add_foreign_key "teaching_managements", "users", column: "teacher_id"
  add_foreign_key "tests", "chapters"
  add_foreign_key "tests", "users", column: "teacher_id"
  add_foreign_key "user_schools", "schools"
  add_foreign_key "user_schools", "users"
end
