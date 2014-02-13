class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :register
      t.string :ic
      t.string :dic
      t.string :adress
      t.string :bank_account
      t.string :hdp
      t.references :user, index: true

      t.timestamps
    end
  end
end
