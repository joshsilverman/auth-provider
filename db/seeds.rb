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

teacher = User.first(:conditions => {:email => "jason@studyegg.com"})
teacher.groups.each do |group|
    25.times do |number|
      student = User.new
      student.email = "student#{number}@studyegg.com"
      student.password = "password"
      student.first_name = "First (#{number})"
      student.last_name = "Last (#{number})"
      student.save    
      group.users << student
    end   
end

