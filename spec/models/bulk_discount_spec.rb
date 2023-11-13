require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "validations" do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity_threshold }
  end
  describe "relationships" do
    it { should belong_to :merchant }
  end

  # describe 'instance methods' do
  #   before(:each) do
  #   end

  # end

  # describe 'class methods' do
  #   before(:each) do
  #   end

  # end
end
