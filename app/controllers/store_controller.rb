
class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products = Product.order(:title)
    @cart = current_cart
  end
  
  def checkout
    @cart = find_cart
    if @cart.empty?
      redirect_to_index("Your cart is empty.")
    else
      @order = Order.new
      @disable_checkout_button = true
    end
  end
end
