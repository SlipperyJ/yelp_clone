require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "doesn't let user submit a name that's too short" do
    restaurant = Restaurant.new(name: 'KF')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'reviews' do
    describe 'build_with_user' do
      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'test' }
      let(:review_params) { { rating: 5, thoughts: 'yum' }}

      subject(:review) { restaurant.reviews.build_with_user( review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a reviwe associated with a particular user' do
        expect(review.user).to eq user
      end
    end
  end


end
