class AddBusinessNameAndStreetAndStreet2AndCityAndPscAndIbanAndSwiftToUser < ActiveRecord::Migration
  def change
    add_column :users, :business_name, :string
    add_column :users, :street, :string
    add_column :users, :street2, :string
    add_column :users, :city, :string
    add_column :users, :PSC, :string
    add_column :users, :IBAN, :string
    add_column :users, :SWIFT, :string
  end
end
