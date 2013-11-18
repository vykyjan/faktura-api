class Client < ActiveRecord::Base
  belongs_to :user
  has_many :invoices,  dependent: :destroy
end
