class Merchant < ApplicationRecord

  has_many :invoices

  def self.ranked_by_revenue(limit_to)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) as revenue")
      .group(:id)
      .order("revenue desc")
      .limit(limit_to)
  end

  def self.ranked_by_items_sold_count(limit_to)
    Merchant.select("merchants.*, SUM(invoice_items.quantity) as total_items")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group(:id)
      .order("total_items desc")
      .limit(limit_to)
  end

  def self.revenue_on_date(date)
      result = Invoice.joins(:invoice_items, :transactions)
        .merge(Transaction.unscoped.successful)
        .where("cast(invoices.created_at AS text) LIKE ?","#{date}%")
        .select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
        .group("invoice_items.id")
        .pluck("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
        .sum
      result
  end

end
