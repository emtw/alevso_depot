class AdminController < ApplicationController

  def index
    if !session[:user_id]
      redirect_to customers_path, notice: 'Please login to access this area.'
    else  
    @total_orders = Order.count
    end
  end
end