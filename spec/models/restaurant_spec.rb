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

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns N/A when there are no reviews' do
        restaurant = Restaurant.new(name: "Moe's Tavern")
        expect(restaurant.average_rating).to eq("N/A")
      end
    end

    context 'one review' do
      it 'returns the rating of the single review owned' do
        restaurant = Restaurant.create(name: "Moe's Tavern")
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq(4)
      end
    end

    context 'multiple reviews' do
      it 'returns the average rating' do
        restaurant = Restaurant.create(name: "Moe's Tavern")
        restaurant.reviews.create(rating: 4)
        restaurant.reviews.create(rating: 2)
        expect(restaurant.average_rating).to eq(3)
      end
    end
  end


end
