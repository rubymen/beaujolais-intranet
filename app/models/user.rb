class User < ActiveRecord::Base
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :firstname,
            presence: true

  validates :lastname,
            presence: true

  validates :type,
            presence: true
end
