class ApiController < ApplicationController

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