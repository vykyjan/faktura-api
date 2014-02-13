class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.text :text
      t.float :number_piece
      t.float :price_piece
      t.float :DPH
      t.references :invoice, index: true

      t.timestamps
    end
  end
end
