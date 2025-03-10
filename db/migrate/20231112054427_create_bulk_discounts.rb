class CreateBulkDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bulk_discounts do |t|
      t.string :name
      t.integer :percentage_discount
      t.integer :quantity_threshold
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
