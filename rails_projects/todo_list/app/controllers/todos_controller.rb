class TodosController < ApplicationController
	before_filter :signed_in_user ,only: [:create,:destroy,:edit,:update,:result]
	def create
		@todo = current_user.tasklists.find_by_id(params[:tasklist_id]).todos.build(params[:todo])
		#debugger
		@todo.due_date = (Date.new(params[:due_date]['due_date(1i)'].to_i,params[:due_date]['due_date(2i)'].to_i,params[:due_date]['due_date(3i)'].to_i)).to_s
		list = current_user.tasklists.find_by_id(params[:tasklist_id])
		if @todo.save
			flash[:success] = 'Item added successfully'
		else
			flash[:failure] = 'Item could not be added'
		end
		redirect_to tasklist_path(list)
	end


	def destroy
		current_user.tasklists.each do | list |
			if list.todos.exists?(params[:id])
				@task_list = list
				@todo = list.todos.find(params[:id])
				break
			end
		end
		if !@todo.nil?
			@todo.destroy
			flash[:success] = "Item deleted successfully"
		else
			flash[:failure]= "Item could not be deleted"
		end
		redirect_to tasklist_path(@task_list)
    end

    def edit
    	@todo = Todo.find(params[:id])
    end

    def update
 		@todo = Todo.find(params[:id])
    	if @todo.update_attributes(params[:todo])
    		@todo.due_date = (Date.new(params[:due_date]['due_date(1i)'].to_i,params[:due_date]['due_date(2i)'].to_i,params[:due_date]['due_date(3i)'].to_i)).to_s
    		@todo.save
    	current_user.tasklists.each do | list |
			if list.todos.exists?(params[:id])
				@task_list = list
				break
			end
		end
    	redirect_to tasklist_path(@task_list)
    else
    	render 'edit'
    end	
    end


    private
    def signed_in_user
    	redirect_to new_session_path unless signed_in?
    end
end
