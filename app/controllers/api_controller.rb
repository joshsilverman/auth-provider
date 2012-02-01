class ApiController < ApplicationController

    def get_edmodo_id
        puts "GET ID"
        user = User.find_by_user_token(params[:user_token])
        unless user
            puts "MAKE A NEW ONE!"
            u = User.new
            u.user_token = params[:user_token]
            u.email = "#{params[:user_token]}edmodo@studyegg.com"
            u.password = params[:user_token]
            u.password_confirmation = params[:user_token]
            if u.save!
                puts "saved"
            else
                puts "error saving"
            end
            user = u

        end
        puts user.id
        render :json => user
    end

    def get_groups_by_user_id
        render :json => User.find(params[:user_id].to_i).groups
    end

	def get_students_by_teacher_id
		render :json => User.all(:conditions => {:teacher_id => params[:teacher_id]})
	end

    def get_students_by_group_id
        render :json => Group.find(params["group_id"]).users.where(:user_type => "STUDENT").select("id, first_name, last_name, email")
    end

	def get_students_by_teacher_email
        students = []
        User.first(:conditions => {:email => params[:email]}).groups.each do |group|
            group.users.each do |student|
                students << student
            end
        end
		render :json => students
	end	
end