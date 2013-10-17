class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :client, index: true
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
