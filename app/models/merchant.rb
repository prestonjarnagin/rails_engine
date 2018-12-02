class Merchant < ApplicationRecord

  has_many :invoices

  has_many :customers, through: :invoices

  def self.ranked_by_revenue(limit_to)
    select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) as revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group(:id)
      .order("revenue desc")
      .limit(limit_to)
  end

  def self.ranked_by_items_sold_count(limit_to)
    select("merchants.*, SUM(invoice_items.quantity) as total_items")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("total_items desc")
      .limit(limit_to)
  end

  def self.revenue_on_date(date)
    Invoice.joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .where("cast(invoices.created_at AS text) LIKE ?","#{date}%")
      .select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .group("invoice_items.id")
      .pluck("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .sum
  end

  def self.revenue_by_merchant(merchant_id)
    Merchant.joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .where(id: merchant_id)
      .select('SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue')
      .group(:id)
      .pluck('SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue')
      .first
  end

  def self.revenue_by_merchant_on_date(merchant_id, date)
    result = Merchant.joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .where("cast(invoices.created_at AS text) LIKE ?","#{date}%")
      .where(id: merchant_id)
      .select('SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue')
      .group(:id)
      .pluck('SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue')
      .first

      return 0 if result.nil?
      result
  end

  def self.favorite_customer(merchant_id)
    Customer.joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .where('invoices.merchant_id = ?', merchant_id)
      .select('customers.id, COUNT(customers.id) AS order_count')
      .group(:id).order('order_count DESC')
      .first
  end

end
