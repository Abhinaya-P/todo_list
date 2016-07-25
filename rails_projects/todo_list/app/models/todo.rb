class Todo < ActiveRecord::Base
  attr_accessible :description, :status
  belongs_to :tasklist

  validates :description,presence: true
  validates :status, presence: true
end
