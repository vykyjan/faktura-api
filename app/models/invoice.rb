class Invoice < ActiveRecord::Base
  belongs_to :client


has_many :pieces

  before_create :numb_invoice

 # before_create :set_per_user_id

  def total_price
    pieces.sum(&:total_price_piece)
  end


  def numb_invoice
    val = @invoice.maximum(:numb_invoice)
    self.numb_invoice = val + 1
  end


end
