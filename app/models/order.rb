class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type, :customer_id
  
  belongs_to :customer
  
   PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
   has_many :line_items, dependent: :destroy
   
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :customer_id, presence: true
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
end
