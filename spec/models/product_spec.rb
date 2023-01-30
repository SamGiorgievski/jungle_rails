require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before (:each) do
      @category = Category.new(name: "category")
    end
    
    it 'the product has name, price, quantity and category fields' do
      @product = Product.new(
        name: "product1", 
        price_cents: 300, 
        quantity: 5, 
        category: @category)
      @product.save
      expect(@product).to be_present
    end

    it 'the product has a name' do
      @product = Product.new(
        name: nil, 
        price_cents: 0, 
        quantity: 10, 
        category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'the product has a price' do
      @product = Product.new(
        name: "product3", 
        price_cents: nil, 
        quantity: 15, 
        category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'the product has a quantity' do
      @product = Product.new(name: "product4", 
      price_cents: 500, 
      quantity: nil, 
      category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'the product has a category' do
      @product = Product.new(name: "product5", 
      price_cents: 750, 
      quantity: 20, 
      category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
