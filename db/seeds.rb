# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create school_admin
school_admin = SchoolAdmin.find_or_create_by(username: "thpt_tamduong") do |user|
  user.first_name = "THPT"
  user.last_name = "Tam Duong"
  user.email = "tamduong@gmail.com"
  user.phone = "0987654321"
  user.password = "Aa@123456"
end

# create school
school = School.find_or_create_by(name: "Trung Hoc Pho Thong Tam Duong") do |s|
  s.location = "Tam Duong, Vinh Phuc, Viet Nam"
end

# create admin user_school
user_school = school.user_schools.find_or_create_by(user_id: school_admin.id)

# create teacher
(1..3).each do |n|
  teacher = Teacher.find_or_create_by(username: "teacher#{n}") do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.email = Faker::Internet.email
    user.phone = Faker::PhoneNumber.cell_phone_in_e164
    user.password = "Aa@123456"
  end

  teacher.user_schools.find_or_create_by(school_id: school.id)
end

# create student
(1...10).each do |n|
  student = Student.find_or_create_by(username: "student#{n}") do |user|
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.email = Faker::Internet.email
    user.phone = Faker::PhoneNumber.cell_phone_in_e164
    user.password = "Aa@123456"
  end

  student.user_schools.find_or_create_by(school_id: school.id)
end

# Mark
school.marks.find_or_create_by(name: "Điểm hệ số 1", rate: 1)
school.marks.find_or_create_by(name: "Điểm hệ số 2", rate: 2)
school.marks.find_or_create_by(name: "Điểm hệ số 3", rate: 3)

# create semester
current_year = DateTime.now.year
hk_1_start = "25-08-#{current_year}".to_datetime
hk_1_end = "10-01-#{current_year + 1}".to_datetime
hk_2_start = "11-01-#{current_year + 1}".to_datetime
hk_2_end = "25-05-#{current_year + 1}".to_datetime
semester1 = school.semesters.find_or_create_by(start_date: hk_1_start, end_date: hk_1_end)
semester2 = school.semesters.find_or_create_by(start_date: hk_2_start, end_date: hk_2_end)

# create grade/levels, study_class
(10...12).each do |n|
  level = school.levels.find_or_create_by(name: n.to_s)
  (1...3).each do |i|
    study_class = level.study_classes.find_or_create_by(semester_id: semester1.id, name: "A#{i}")
    Student.all.each do |student|
      student.student_study_classes.find_or_create_by(study_class_id: study_class.id)
    end

    study_class.teaching_managements.find_or_create_by(teacher_id: Teacher.first)
  end
end

# create subject, chapters and section_class
subjects = ["Toan", "Ly", "Hoa", "Sinh", "Van", "Su", "Dia", "Giao duc cong dan", "Tieng Anh", "Tin hoc"]
subjects.each do |value|
  subject = school.subjects.find_or_create_by(name: value)
  (1...5).each do |n|
    subject.chapters.find_or_create_by(level_id: Level.first.id, name: "chương #{n}")
  end
  StudyClass.all.each do |study_class|
    section_class = study_class.section_classes.find_or_create_by(subject_id: subject.id)
  end
end

# Teacher math
Teacher.first.teacher_section_classes.find_or_create_by(section_class_id: SectionClass.first.id)
Teacher.first.teacher_section_classes.find_or_create_by(section_class_id: SectionClass.second.id)
Teacher.second.teacher_section_classes.find_or_create_by(section_class_id: SectionClass.second.id)
Teacher.third.teacher_section_classes.find_or_create_by(section_class_id: SectionClass.second.id)
