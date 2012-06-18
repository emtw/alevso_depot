module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
  
  def show_products
    @order = Order.find(params[:id])
    @line_items = @order.line_items
    @products = @line_items.product
    
    
  end
  
end
