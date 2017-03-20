class Listing < ApplicationRecord
  belongs_to :user
  has_many :tags, :through => :taggings
  has_many :taggings
end
