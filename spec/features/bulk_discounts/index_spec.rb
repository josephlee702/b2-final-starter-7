require "rails_helper"

RSpec.describe "merchant's bulk discounts index page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
    @bulk_discount1 = @merchant1.bulk_discounts.create!(name: "Bulk Discount A",percentage_discount: 20, quantity_threshold: 10)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it "can see a link to my merchant dashboard" do
    expect(page).to have_link("Dashboard")

    click_link "Dashboard"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/dashboard")
  end

  it "can see a link to my merchant items index" do
    expect(page).to have_link("Items")

    click_link "Items"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
  end

  it "can see a link to my merchant invoices index" do
    expect(page).to have_link("Invoices")

    click_link "Invoices"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
  end

  it "can see a link to my merchant bulk discounts" do
    expect(page).to have_link("My Discounts")

    click_link "My Discounts"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
  end

  it "shows the merchant's bulk discounts" do
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content("My Bulk Discounts")
    expect(page).to have_link(@bulk_discount1.name)
    expect(page).to have_content("Percentage Discount: #{@bulk_discount1.percentage_discount}%")
    expect(page).to have_content("Quantity Threshold: at least #{@bulk_discount1.quantity_threshold} of any item")

    click_on(@bulk_discount1.name)
    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/#{@bulk_discount1.id}")
  end

  it "shows a link to create a bulk discount" do
    expect(page).to have_link("Create Bulk Discount")
    click_on("Create Bulk Discount")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/new")
  end

  it "shows a button to delete a bulk discount" do
    expect(page).to have_content("Bulk Discount A")
    expect(page).to have_button("Delete")
    click_on("Delete")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
    expect(page).to_not have_content("Bulk Discount A")
  end
end
