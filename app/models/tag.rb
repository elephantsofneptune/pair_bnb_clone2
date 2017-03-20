class Tag < ApplicationRecord
  has_many :listings, :through => :taggings
  has_many :taggings
end
