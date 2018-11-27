require 'csv'
require 'pry'
namespace :import do

  desc "Import all CSV files"
  task all: :environment do
    Rake::Task["import:merchants"].execute
    Rake::Task["import:customers"].execute
    Rake::Task["import:invoices"].execute
    Rake::Task["import:items"].execute
    Rake::Task["import:invoice_items"].execute
    Rake::Task["import:transactions"].execute
  end

  task merchants: :environment do
    filename = File.join(Rails.root, "/csv/merchants.csv")
    total = 0
    CSV.foreach(filename, headers: true) do |row|
      params = {
        name: row['name'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      }
      total += 1 if Merchant.create!(params)
    end
    puts "Created #{total} merchants"
  end

  task customers: :environment do
    filename = File.join(Rails.root, "/csv/customers.csv")
    total = 0
    CSV.foreach(filename, headers: true) do |row|
      params = {
        first_name: row['first_name'],
        last_name: row['last_name'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      }
      total += 1 if Customer.create!(params)
    end
    puts "Created #{total} customers"
  end

  task invoices: :environment do
    filename = File.join(Rails.root, "/csv/invoices.csv")
    total = 0
    CSV.foreach(filename, headers: true) do |row|
      params = {
        customer_id: row['customer_id'],
        merchant_id: row['merchant_id'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      }
      total += 1 if Invoice.create!(params)
    end
    puts "Created #{total} invoices"
  end

  task items: :environment do
    filename = File.join(Rails.root, "/csv/items.csv")
    total = 0
    CSV.foreach(filename, headers: true) do |row|
      params = {
        name: row['name'],
        description: row['description'],
        unit_price: row['unit_price'],
        merchant_id: row['merchant_id'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      }
      total += 1 if Item.create!(params)
    end
    puts "Created #{total} items"
  end

  task invoice_items: :environment do
    filename = File.join(Rails.root, "/csv/invoice_items.csv")
    total = 0
    CSV.foreach(filename, headers: true) do |row|
      params = {
        item_id: row['item_id'],
        invoice_id: row['invoice_id'],
        unit_price: row['unit_price'],
        quantity: row['quantity'],
        updated_at: row['updated_at']
      }
      total += 1 if InvoiceItem.create!(params)
    end
    puts "Created #{total} invoice_items"
  end

  task transactions: :environment do
    filename = File.join(Rails.root, "/csv/transactions.csv")
    total = 0
    CSV.foreach(filename, headers: true) do |row|
      params = {
        invoice_id: row['invoice_id'],
        credit_card_number: row['credit_card_number'],
        credit_card_expiration_date: row['credit_card_expiration_date'],
        result: row['result'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      }
      total += 1 if Transaction.create!(params)
    end
    puts "Created #{total} transactions"
  end

end
