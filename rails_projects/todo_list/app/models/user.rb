class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  before_save { |user| user.email = email.downcase }
  before_save  { create_remember_token }

  has_secure_password
  has_many :tasklists, dependent: :destroy
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password_confirmation, presence: true, length: { minimum: 8 }
  validates :password, presence: true, length: { minimum: 8 }

  def get_notifications(user)
    notifications = []
    user.tasklists.each do | list |
      list.todos.find_all_by_alert_and_status(true,"In Progress").each do | item |
        end_date = Date.parse(item.due_date)
        today_date = Date.today
        days = (end_date - today_date).to_i
        if days <= 3 && days > 0
            msg = "You have #{days} #{days >1 ? "more days" : "more day" } to complete task of #{item.description.downcase}"
            notifications << msg
        end
      end
    end
    return notifications
  end

  private
  def create_remember_token
  	self.remember_token = "#{self.email}#{self.name}"
  end

end
