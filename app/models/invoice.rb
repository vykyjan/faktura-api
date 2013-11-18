class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :user

has_many :pieces

  before_create :create_numb_invoice

 # before_create :set_per_user_id

  def total_price
    pieces.sum(&:total_price_piece)
  end


 def create_numb_invoice
   val = user.invoices.maximum(:numb_invoice)
   if val ==
     val = 0
   end
   self.numb_invoice = val + 1
 end


end
