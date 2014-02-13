class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :register, :string
    add_column :users, :ic, :string
    add_column :users, :dic, :string
    add_column :users, :adress, :string
    add_column :users, :bank_account, :string
    add_column :users, :dph, :string
  end
end
