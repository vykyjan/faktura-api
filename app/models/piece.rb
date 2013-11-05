class Piece < ActiveRecord::Base
  belongs_to :invoice



   def total_price_piece
     number_piece * price_piece
   end

end
