
class OrdersController < ApplicationController
  
  skip_before_filter :authorize, only: [:new, :create]
  
  # GET /orders
  # GET /orders.json
  def index
    if !session[:user_id]
      redirect_to customers_path, notice: 'Please login to access this area.'
      return
     else
    @orders = Order.paginate page: params[:page], order: 'created_at desc',
      per_page: 10
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    
    @order = Order.find(params[:id])
    
      if session[:user_id]
      @order = Order.find(params[:id])  
     
     elsif session[:customer_id] != @order.customer_id
       redirect_to customers_path(session[:customer_id])
       return
          
    else
          
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
      end
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    
    @customer_id = session[:customer_id]
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    else
    @order = Order.new
    end
    
    unless session[:customer_id]
      redirect_to new_customer_path
    else

    respond_to do |format|
      format.html # new.html.erb
      format.json 
     end
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    customer_id = Customer.new(params[:customer_id])
    current_user = session[:customer_id]
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifier.received(@order).deliver
        format.html { redirect_to customer_path(session[:customer_id]), notice: 'Thank you for your order' }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
    def update
    @order = Order.find(params[:id])
    @order.attributes = params[:order]

    ship_date_changed = @order.ship_date_changed?

    respond_to do |format|
      if @order.save
        OrderNotifier.shipped(@order).deliver if ship_date_changed

        format.html { redirect_to @order, :notice => 'Order was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if !session[:user_id]
      redirect_to customers_path, notice: 'Please contact us if you wish to cancel an order.'
    return
    else
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
    end
  end
end
