class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash.now[:success] = "User created successfully"
			redirect_to new_session_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find_by_id(params[:id])
	end

	def notifications
		@notifications = (current_user.get_notifications(current_user)).paginate(page: params[:page],per_page: 20)
	end
end
