require 'factory_girl'
require 'forgery'

FactoryGirl.define do
  factory :user do
    email { Forgery(:internet).email_address }
    firstname { Forgery(:name).first_name }
    lastname { Forgery(:name).last_name }
    pwd = Forgery(:basic).password
    password { pwd }
    password_confirmation { pwd }
    type { ['Admin', 'Customer'].shuffle.first }
  end
end
