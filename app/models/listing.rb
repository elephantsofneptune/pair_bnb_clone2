class Listing < ApplicationRecord
  belongs_to :user
  has_many :tags, :through => :taggings
  has_many :taggings

  validates :title, presence: true
  validates :address, presence: true
  validates :pax, presence: true
end
