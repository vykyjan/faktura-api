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
  end

  def new
    @clients = Client.all
    @invoice = Invoice.new
  end

  def create
    @invoice = current_user.invoices.new(post_params)
    @invoice.save

    InvoiceMailer.invoice_info(invoice, current_user).deliver
    redirect_to @invoice

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


  InvoiceMailer.invoice_info(invoice, current_user).deliver
  end

  def tisk
    invoice = Invoice.find(params[:id])

    invoice_one(invoice, current_user)
    send_file(Rails.root.join('tmp', "faktura.pdf"), :filename => "output.pdf", :type => "application/pdf")
  end

  private
  def post_params

    params.require(:invoice).permit(:description, :price, :client_id, :user_id, :var_symbol, :konst_symbol, :numb_invoice, :date_of_issue, :date_of_the_chargeable_event, :due_date, :payment_date, :total_price)
  end

  def show_navbar
    @show_navbar = false
  end
end
