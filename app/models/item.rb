class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.rank_by_revenue(limit_to)
    joins(:invoice_items, invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .select('items.id, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
      .group('items.id')
      .order('revenue DESC')
      .limit(limit_to)
  end

  def self.rank_by_quantity_sold(limit_to)
    joins(:invoice_items, invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .select('items.id, SUM(invoice_items.quantity) AS quantity')
      .group(:id)
      .order('quantity DESC')
  end

  def self.best_day(item_id)
    Item.joins(invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .where(id: item_id)
      .select('CAST(invoices.created_at AS DATE) AS date, SUM(invoice_items.quantity) AS sold')
      .group('date')
      .order('sold DESC, date DESC')
      .first
      .date
  end
end
