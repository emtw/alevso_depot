
class CustomersController < ApplicationController
  skip_before_filter :authorize, only: [:create, :new]
  
  # GET /customers
  # GET /customers.json
  def index
    if !session[:user_id]
      redirect_to customer_path(session[:customer_id]) , notice: 'Access Denied'
    return
    else
    @customers = Customer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    if customer_path(session[:customer_id])!=customer_path
      redirect_to customer_path(session[:customer_id]), notice: 'Access denied. Please login to view this account.'
    else
      @customer = Customer.find(params[:id])
      @orders = @customer.orders.paginate page: params[:page], order: 'id desc',
      per_page: 5

      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new
    @title = "Sign Up"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
    def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        session[:customer_id] = @customer.id
        format.html { redirect_to new_order_path, method: :get, notice: "Your account was successfully created." }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to customer_path(session[:customer_id]), notice: 'Your account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
end
