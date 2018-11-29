class Transaction < ApplicationRecord
  belongs_to :invoice

  default_scope { order(:id) }

  scope :successful, -> { where(result: 'success') }
end
