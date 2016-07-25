class TasklistsController < ApplicationController
  def new
  end

  def create

     	@list = current_user.tasklists.build(params[:tasklist])
     	if @list.save
                redirect_to current_user
    	else
    	render 'new'
        end
  end

  def show
       @list = current_user.tasklists.find(params[:id])
  end

  def destroy
     @list = current_user.tasklists.find(params[:id])
     @list.destroy
     flash[:success] = "List has been deleted successfully"
     redirect_to(user_path(current_user))
  end
end
