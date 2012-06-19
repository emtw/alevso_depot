
class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    if !session[:user_id]
      redirect_to customers_path, notice: 'Please login to access this area.'
    return
    else
    @products = Product.paginate page: params[:page], order: 'title',
      per_page: 10
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if !session[:user_id]
      redirect_to store_url, notice: 'Please login to access this area.'
    return
    else
    @product = Product.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    if !session[:user_id]
      redirect_to store_url, notice: 'Please login to access this area.'
    return
    else
    @product = Product.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
    end
  end

  # GET /products/1/edit
  def edit
    if !session[:user_id]
      redirect_to store_url, notice: 'Please login to access this area.'
    return
    else
    @product = Product.find(params[:id])
    end
  end

  # POST /products
  # POST /products.json
  def create
    if !session[:user_id]
      redirect_to store_url, notice: 'Please login to access this area.'
    return
    else
    @product = Product.new(params[:product])
  
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    if !session[:user_id]
      redirect_to store_url, notice: 'Please login to access this area.'
    return
    else
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if !session[:user_id]
      redirect_to store_url, notice: 'Please login to access this area.'
    return
    else
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
    end
  end
  
  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
    end
  end
end
