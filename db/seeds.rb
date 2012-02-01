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

teacher = User.create!(:email => "jason@studyegg.com", :password => "password", :first_name => "Jason", :last_name => "Urton", :user_type => "TEACHER")
class1 = Group.create!(:edmodo_id => 1, :title => "Introduction to Biology (Section 1)")
# class2 = Group.create!(:edmodo_id => 2, :title => "Introduction to Biology (Section 2)")
teacher.groups << class1
# teacher.groups << class2

teacher.groups.each do |group|
    puts "#{group}\n\n"
    25.times do |number|
      group.users << User.create!(
        :email => "student#{group.id}_#{number}@studyegg.com",
        :password => "password",
        :first_name => "First (#{number})",
        :last_name => "Last (#{number})",
        :user_type => "STUDENT"
      )
    end   
end

