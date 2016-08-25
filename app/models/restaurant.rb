require_relative 'with_user_association_extension'
class Restaurant < ActiveRecord::Base
  include WithUserAssociationExtension
  has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy


  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return "N/A" if reviews.none?

    rating_total = reviews.inject(0) { |total, review| total + review.rating.to_i }
    rating_total / reviews.count
  end
end
