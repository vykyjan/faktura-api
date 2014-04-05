# coding: utf-8
require "reports/tisk"
require 'prawn'
class InvoicesController < ApplicationController
  before_filter :show_navbar
  helper Tisk
  include Tisk

  def index
    @invoices = current_user.invoices
    @clients = Client.all
    @cart = current_cart
  end

  def new
    @clients = Client.all
    @invoice = Invoice.new
  end

  def create

    @invoice = current_user.invoices.new(post_params)

    piece = @invoice.pieces

    respond_to do |format|
      if @invoice.save
       # invoice_one(@invoice, current_user, piece)
        #InvoiceMailer.invoice_info(@invoice, current_user).deliver

        format.html { redirect_to(@invoice, notice: 'Faktura byla úspěšně vytvořena a byla odeslána klientovi') }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: 'new' }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end



  end

  def show
    @invoice = Invoice.find(params[:id])

    @users = current_user[:id]
    @pieces = @invoice.pieces.all


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice }
      format.pdf { render :layout => false } # Add this line
    end


  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(post_params)
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

  def mail
  invoice = Invoice.find(params[:id])

  InvoiceMailer.invoice_info(invoice, current_user, piece).deliver
  end

  def thanks
  @invoice = Invoice.find(params[:id])

    InvoiceMailer.thanks(@invoice, current_user, piece).deliver

  end

  def reminder_email
    invoice = Invoice.find(params[:id])
    @invoice = Invoice.find(params[:id])
    if Invoice.update(@invoice, :reminder => Time.now)
      render 'reminder_email'
    else
      render 'index'
    end
    invoice_one(invoice, current_user)
    InvoiceMailer.reminder_email(invoice, current_user).deliver
   #
  end

  def tisk
    invoice = Invoice.find(params[:id])
    @invoice = Invoice.find(params[:id])
    piece = invoice.pieces

    invoice_one(invoice, current_user, piece)
    send_file(Rails.root.join('tmp', 'documents', "#{Invoice.object_id}.pdf"), :filename => "faktura.pdf", :type => "application/pdf")
  end

  def clone
    @invoice = Invoice.new
    @invoice1 = Invoice.find(params[:id])
 #@invoice = Invoice.find(params[:id]).clone
  #if @invoice.save
   #flash[:notice] = 'Faktura byla úspěšně duplikovaná.'
   # else
    #  flash[:notice] = 'Chyba: fakturu se nepodařilo duplikovat.'
    #end

  end





  private
  def post_params

    params.require(:invoice).permit(:description, :price, :client_id, :user_id, :var_symbol, :konst_symbol, :numb_invoice, :date_of_issue, :date_of_the_chargeable_event, :due_date, :payment_date, :total_price, :reminder)
  end



  def show_navbar
    @show_navbar = false
  end
end
