
class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products = Product.paginate page: params[:page], order: 'title',
      per_page: 10
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
