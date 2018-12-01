class Customer < ApplicationRecord
  has_many :invoices

  has_many :merchants, through: :invoices

  def self.favorite_merchant(customer_id)
    Merchant.joins(:customers, invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .where('customers.id = ?', customer_id)
      .select('merchants.*, COUNT(merchants.id)')
      .group('merchants.id')
      .order('COUNT(merchants.id) DESC')
      .first
  end
end
