class ChangeNumberInvoiceToInvoice < ActiveRecord::Migration
  def up
    connection.execute(%q{
    alter table invoices
    alter column numb_invoice
    type integer using cast(numb_invoice as integer)
  })
  end

  def down
    change_table :invoices do |t|
      t.change :numb_invoice, :string
    end
  end
  end
