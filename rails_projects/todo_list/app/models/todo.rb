class Todo < ActiveRecord::Base
  attr_accessible :description, :status, :alert, :due_date,:priority
  belongs_to :tasklist

  validates :description,presence: true
  validates :status, presence: true
  validates :priority, presence:true
end
