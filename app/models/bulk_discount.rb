class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount,
                        :quantity_threshold

  belongs_to :merchant
  has_many :item_bulk_discounts
  has_many :items, through: :item_bulk_discounts
end
