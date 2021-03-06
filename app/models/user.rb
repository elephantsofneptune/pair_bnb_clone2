require 'carrierwave/orm/activerecord'

class User < ApplicationRecord
  include Clearance::User 

  mount_uploader :avatar, AvatarUploader
  
  validates_confirmation_of :password

  validates :first_name,            presence: true
  validates :last_name,             presence: true
  has_many  :authentications,       dependent: :destroy
  has_many  :listings,              dependent: :destroy



  def self.create_with_auth_and_hash(authentication, auth_hash)
      user = User.create!(
                          first_name: get_first_name(auth_hash[:info][:name]),
                          last_name:  get_last_name(auth_hash[:info][:name]),
                          email:      auth_hash[:info][:email]
                          )
      user.authentications << (authentication)      
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    byebug
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
  
  def self.get_first_name(full_name)
    full_name.split(" ")[0]
  end

  def self.get_last_name(full_name)
    full_name.split(" ")[1..-1].join(" ")
  end
end
