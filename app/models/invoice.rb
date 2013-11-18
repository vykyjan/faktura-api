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
     if val.nil?
      self.numb_invoice = 1
    else
      self.numb_invoice = val + 1
    end




 end




end
