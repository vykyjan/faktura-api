class LineItemsController < ApplicationController



  def index
    @line_items = LineItem.all
  end

  def new
    @line_item = LineItem.new
  end

  def show
    @line_item = LineItem.find(params[:id])
  end

  def create
    @cart = current_cart
    invoice = Invoice.find(params[:invoice_id])
    @line_item = @cart.line_items.build(:invoice_id => invoice.id)
    @line_item.invoice = invoice



    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(@line_item.cart,
                                  :notice => 'Faktura byla přidána') }
        format.xml  { render :xml => @line_item,
                             :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors,
                             :status => :unprocessable_entity }
      end
    end
    end

  private

  def line_item_params
    params.require(:line_item).permit(:invoice_id, :cart_id)
  end
end
