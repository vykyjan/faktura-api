class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
    @clients = Client.all
  end

  def new
    @clients = Client.all
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(post_params)

    @invoice.save
    redirect_to @invoice
  end

  def show
    @invoice = Invoice.find(params[:id])
    @user = current_user[:id]
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(params[:invoice].permit(:description, :price))
      redirect_to @invoice
    else
      render 'edit'
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    redirect_to invoices_path
  end


  private
  def post_params

    params.require(:invoice).permit(:description, :price, :client_id)
  end
end
