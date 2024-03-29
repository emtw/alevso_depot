class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    customer = Customer.find_by_email(params[:email])
    
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    
    elsif customer and customer.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to customer_path(session[:customer_id]) 
    
    else
      redirect_to login_url, notice: "Invalid username/password combination"
    end
    
    
  end

  def destroy
    session[:user_id] = nil
    session[:customer_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end