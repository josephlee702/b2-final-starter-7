class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end
  
  def discount_applied
    sql_query = <<-SQL
      SELECT big_table.name, big_table.percentage_discount
      FROM (
        SELECT "invoice_items".*, bulk_discounts.*
        FROM "invoice_items"
        INNER JOIN "items" ON "items"."id" = "invoice_items"."item_id"
        INNER JOIN "merchants" ON "merchants"."id" = "items"."merchant_id"
        INNER JOIN "bulk_discounts" ON "bulk_discounts"."merchant_id" = "merchants"."id"
        WHERE "invoice_items"."quantity" >= "bulk_discounts"."quantity_threshold"
      ) AS big_table
      ORDER BY big_table.percentage_discount DESC
    SQL
    
    results = InvoiceItem.find_by_sql(sql_query).first.name
    results
  end
end

# InvoiceItem.joins(item: {merchant: :bulk_discounts}).where("invoice_items.quantity >= bulk_discounts.quantity_threshold").group("invoice_items.id")