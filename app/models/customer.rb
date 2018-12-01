class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_merchant(customer_id)
    Merchant.joins(invoices: [:customers])
  end
end
