class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash.now[:success] = "User created successfully"
			redirect_to home_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find_by_id(params[:id])
	end
end
