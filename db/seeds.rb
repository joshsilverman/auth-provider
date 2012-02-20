# ClientApplication.delete_all
# User.delete_all

# ClientApplication.create(
#   :name => "secret",
#   :app_id => "demo_id",
#   :app_secret => "demo_secret"
# )

# User.create(
#   :username => "demo",
#   :password_hash => User.hash_password("password", "salt"),
#   :password_salt => "salt",
#   :status => "Active",
#   :expiration_date => "2020-01-01"
# )

ed_teacher = User.create!(:email => "ed_teacher@studyegg.com",
                        :password => "password",
                        :first_name => "Edmodo",
                        :last_name => "Teacher",
                        :user_type => "TEACHER",
                        :user_token => "330d83cb6")

ed_student = User.create!(:email => "ed_student@studyegg.com",
                        :password => "password",
                        :first_name => "Edmodo",
                        :last_name => "Student",
                        :user_type => "STUDENT",
                        :user_token => "052e6ebb6")

se_teacher = User.create!(:email => "se_teacher@studyegg.com",
                        :password => "password",
                        :first_name => "Studyegg",
                        :last_name => "Teacher",
                        :user_type => "TEACHER",
                        :id => 999999)

se_student = User.create!(:email => "se_student@studyegg.com",
                        :password => "password",
                        :first_name => "Studyegg",
                        :last_name => "Student")

und_student = User.create!(:email => "und_student@studyegg.com",
                        :password => "password",
                        :first_name => "Und",
                        :last_name => "Student",
                        :school => "und")

class1 = Group.create!(:title => "Introduction to Biology (Section 1)")
# class2 = Group.create!(:title => "Introduction to Biology (Section 2)")
se_teacher.groups << class1
# teacher.groups << class2

se_teacher.groups.each do |group|
    puts "#{group}\n\n"
    25.times do |number|
      group.users << User.create!(
        :email => "student_#{number}@studyegg.com",
        :password => "password",
        :first_name => "First (#{number})",
        :last_name => "Last (#{number})",
        :user_type => "STUDENT"
      )
    end   
end

