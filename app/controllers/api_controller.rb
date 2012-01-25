class ApiController < ApplicationController

    def get_groups_by_user_id
        puts params[:user_id]
    end

	def get_students_by_teacher_id
        puts params.to_json
		render :json => User.all(:conditions => {:teacher_id => params[:teacher_id]})
	end

	def get_students_by_teacher_email
		render :json => User.all(:conditions => {:teacher_id => User.first(:conditions => {:email => params[:email]}).id})
	end	
end