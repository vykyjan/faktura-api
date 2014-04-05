class CartsController < ApplicationController
protect_from_forgery



  def show
    begin
    @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Pokus o přístup k neplatnému košíku #{params[:id]}"
      redirect_to invoice_url, :notice => 'Neplatný košík'
else
respond_to do |format|
  format.html # show.html.erb
  format.xml {render :xml => @cart}
end
    end
    end

  def new
    @cart = Cart.new
    end

  def create
    @cart = Cart.new(cart_params)

    @cart.save
    redirect_to @cart
  end



def destroy
  @cart = Cart.find(params[:id])
  @cart.destroy

  respond_to do |format|
    format.html { redirect_to carts_url }
    format.json { head :no_content }
  end
end




  def cart_params
    params.require(:cart).permit()
  end
end
