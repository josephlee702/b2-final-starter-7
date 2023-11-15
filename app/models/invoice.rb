class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue
    x = (invoice_items.joins(item: {merchant: :bulk_discounts})
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select("MAX((invoice_items.quantity * invoice_items.unit_price) * (bulk_discounts.percentage_discount/100.0)) as amount_discounted") 
    .group("invoice_items.id")).to_sql

    discounts = (Invoice.select("SUM(total_discount_table.amount_discounted)").from("(#{x}) as total_discount_table"))[0].sum.to_f
    total_revenue - discounts
  end
end
