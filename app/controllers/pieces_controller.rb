require "reports/tisk"
require 'prawn'
class PiecesController < ApplicationController
  helper Tisk
  include Tisk
  # GET /orders/1/items
  def index
    @invoice = Invoice.find(params[:invoice_id])


    @pieces = @invoice.pieces
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @piece = @invoice.pieces.find(params[:id])
  end

  def new
    @invoice = Invoice.find(params[:invoice_id])
    @piece = @invoice.pieces.build
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])

    @piece = @invoice.pieces.build(post_params)
    if @piece.save
      # Save the item successfully
      redirect_to invoice_piece_url(@invoice, @piece)
    else
      render :action => "new"
    end
  end

  # GET /orders/1/items/2/edit
  def edit
    @invoice = Invoice.find(params[:invoice_id])

    # For URL like /orders/1/items/2/edit
    # Get item id=2 for order 1
    @piece = @invoice.pieces.find(params[:id])
  end

  # PUT /orders/1/items/2
  def update
    @invoice = Invoice.find(params[:invoice_id])
    @piece = Piece.find(params[:id])
    if @piece.update_attributes(params[:post_params])
      # Save the item successfully
      redirect_to invoice_piece_url(@invoice, @piece)
    else
      render :action => "edit"
    end
  end

  # DELETE /orders/1/items/2
  def destroy
    @invoice = Invoice.find(params[:invoice_id])
    @piece = Piece.find(params[:id])
    @piece.destroy

    respond_to do |format|
      format.html { redirect_to invoice_pieces_path(@invoice) }
      format.xml  { head :ok }
    end
  end

  private
  def post_params

    params.require(:piece).permit(:text, :number_piece, :price_piece, :DPH)
  end
end
