class LineItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :cart

  def total_price
    invoice.total_price
  end
end
