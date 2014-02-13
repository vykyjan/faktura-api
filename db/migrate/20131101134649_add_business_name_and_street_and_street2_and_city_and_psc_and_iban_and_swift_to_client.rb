class AddBusinessNameAndStreetAndStreet2AndCityAndPscAndIbanAndSwiftToClient < ActiveRecord::Migration
  def change
    add_column :clients, :business_name, :string
    add_column :clients, :street, :string
    add_column :clients, :street2, :string
    add_column :clients, :city, :string
    add_column :clients, :PSC, :string
    add_column :clients, :IBAN, :string
    add_column :clients, :SWIFT, :string
  end
end
