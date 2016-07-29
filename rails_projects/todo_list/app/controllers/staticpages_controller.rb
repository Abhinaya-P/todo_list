class StaticpagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def result
    	@result = Todo.search_result(params[:search],current_user).paginate(page: params[:page],per_page: 20)
  end
end
