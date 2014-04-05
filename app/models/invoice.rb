class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :user

has_many :pieces
  has_many :line_items

  before_save :create_numb_invoice
  before_destroy :ensure_not_referenced_by_any_line_item

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

  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Existuji položky')
      return false
    end
  end

end
