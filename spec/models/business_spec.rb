require 'rails_helper'
RSpec.describe Business, type: :model do
  it 'Valid if name is present' do
    @user = User.create!(name: 'johnson', email: 'johnson@gmail.com', password: 123_456)
    @business = Business.create(name: 'sports', amount: 200, author_id: @user.id)
    expect(@business).to be_valid
  end

  it 'Invalid if name is absent' do
    @user = User.create!(name: 'johnson', email: 'johnson@gmail.com', password: 123_456)
    @business = Business.create(amount: 200, author_id: @user.id)
    expect(@business).to be_valid
  end

  it 'Invalid if amount is absent' do
    @user = User.create!(name: 'johnson', email: 'johnson@gmail.com', password: 123_456)
    @business = Business.create(name: 'goods', author_id: @user.id)
    expect(@business).to_not be_valid
  end

  it 'must be associated with a category' do
    @user = User.create!(name: 'johnson', email: 'johnson@gmail.com', password: 123_456)
    @category = Category.create(name: 'sport', icon: 'www.tech.com', user_id: @user.id)
    @business = Business.create(name: 'goods', amount: 200, author_id: @user.id)
    @category_businesses = @business.category_businesses.create(business_id: @business.id, category_id: @category.id)
    expect(@category_businesses).to be_valid
  end
end
