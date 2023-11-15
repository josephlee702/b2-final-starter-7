# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

@merchant1 = Merchant.create!(name: "Hair Care")

@customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
@customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")

@invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
@invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
@invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)

@item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
@item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
@item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
@item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

@ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
@ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 12, unit_price: 8, status: 0)
@ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
@ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

@transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
@transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)

@bulk_discount1 = @merchant1.bulk_discounts.create!(name: "Bulk Discount A", percentage_discount: 20, quantity_threshold: 10)

# @merchant1 = Merchant.create!(name: 'Hair Care')
# @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
# @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
# @item_2 = Item.create!(name: "bicycle", description: "You ride this", unit_price: 5, merchant_id: @merchant1.id)
# @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
# @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
# @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
# @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 8, status: 2)
# @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 15, unit_price: 10, status: 2)
# @bulk_discount1 = @merchant1.bulk_discounts.create!(name: "Bulk Discount A", percentage_discount: 20, quantity_threshold: 10)
# @bulk_discount2 = @merchant1.bulk_discounts.create!(name: "Bulk Discount B", percentage_discount: 50, quantity_threshold: 10)