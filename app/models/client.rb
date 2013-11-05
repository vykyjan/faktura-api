class Client < ActiveRecord::Base

  has_many :invoices,  dependent: :destroy
end
