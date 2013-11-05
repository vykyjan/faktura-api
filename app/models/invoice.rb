class Invoice < ActiveRecord::Base
  belongs_to :client

has_many :pieces



 # before_create :set_per_user_id

  def total_price
    pieces.sum(&:total_price_piece)
  end

 # def set_per_user_id
  #  val = user.projects.maximum(:document_id)
   # self.document_id = val + 1
 # end


end
