class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @new_bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)

    if @new_bulk_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
      flash[:notice] = "This bulk discount was successfully saved!"
    else
      render :new
    end
  end

  private

  def bulk_discount_params
    params.permit(:name, :percentage_discount, :quantity_threshold)
  end
end
