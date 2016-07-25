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


  private
  def create_remember_token
  	self.remember_token = "#{self.email}#{self.name}"
  end
end
