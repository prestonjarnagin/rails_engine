class Merchant < ApplicationRecord

  def self.ranked_by_revenue(limit)
    transaction_ids = Transaction.where(result: :success)
      .pluck(:invoice_id)
    invoice_ids = Invoice.find(transaction_ids)
      .pluck(ids)

  end

end
