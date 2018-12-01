class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.rank_by_revenue(limit_to)
      Item.joins(:invoice_items, invoices: [:transactions])
        .merge(Transaction.unscoped.successful)
        .select('items.id, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
        .group('items.id')
        .order('revenue DESC')
        .limit(limit_to)
  end

end
