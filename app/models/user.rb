require 'mail'
class User < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :name, :password, :password_confirmation, :email
  
  validates :name, presence: true
  validates :email, presence:true, :uniqueness => {:case_sensitive => false}, :email => true
  has_secure_password
  
  after_destroy :ensure_an_admin_remains
  
  private
    
    def ensure_an_admin_remails
      if User.count.zero?
        raise "Can't delete last user"
      end
    end
end
