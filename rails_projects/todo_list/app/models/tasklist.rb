class Tasklist < ActiveRecord::Base
  attr_accessible :name
  has_many :todos,dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
end
