class AddTotatPricePiece < ActiveRecord::Migration
  def change
    add_column :pieces, :total_price_piece, :float
  end
end
