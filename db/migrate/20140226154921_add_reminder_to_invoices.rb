class AddReminderToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :reminder, :date
  end
end
