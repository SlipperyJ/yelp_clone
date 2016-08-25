require_relative 'with_user_association_extension'
class Restaurant < ActiveRecord::Base
  include WithUserAssociationExtension
  has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy


  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true
end
