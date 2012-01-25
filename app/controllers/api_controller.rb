class ApiController < ApplicationController
	def get_students_by_teacher_id
		render :json => User.all(:conditions => {:teacher_id => params[:teacher_id]})
	end

	def get_students_by_teacher_email
		render :json => User.all(:conditions => {:teacher_id => User.first(:conditions => {:email => params[:email]}).id})
	end	
end