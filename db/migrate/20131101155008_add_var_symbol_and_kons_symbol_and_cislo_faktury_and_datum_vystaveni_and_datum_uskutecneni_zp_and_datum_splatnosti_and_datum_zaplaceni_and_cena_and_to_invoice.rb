class AddVarSymbolAndKonsSymbolAndCisloFakturyAndDatumVystaveniAndDatumUskutecneniZpAndDatumSplatnostiAndDatumZaplaceniAndCenaAndToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :var_symbol, :string
    add_column :invoices, :konst_symbol, :string
    add_column :invoices, :numb_invoice, :string
    add_column :invoices, :date_of_issue, :date
    add_column :invoices, :date_of_the_chargeable_event, :date
    add_column :invoices, :due_date, :date
    add_column :invoices, :payment_date, :date
    add_column :invoices, :total_price, :float
  end
end
