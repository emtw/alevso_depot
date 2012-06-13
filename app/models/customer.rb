require 'mail'
class Customer < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :address, :email, :name, :password, :password_confirmation
  
  has_many :orders
  
  validates :name, presence:true, :length => { :maximum => 50 }
  validates :email, presence:true, :uniqueness => {:case_sensitive => false}, :email => true
  validates :address, presence:true
  has_secure_password
  
end
