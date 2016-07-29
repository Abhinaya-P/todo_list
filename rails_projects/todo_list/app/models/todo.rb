class Todo < ActiveRecord::Base
  attr_accessible :description, :status, :alert, :due_date,:priority
  belongs_to :tasklist

  validates :description,presence: true
  validates :status, presence: true
  validates :priority, presence:true

  def self.search_result(search_text,user)
  	res = []
  	if !search_text.empty?
  		user.tasklists.each do | list |
  			list.todos.each do | item |
  				res << item if item.description.downcase.include?(search_text.downcase)
  			end
  		end
  	end
  	res
  end
end
