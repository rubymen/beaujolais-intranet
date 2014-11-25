namespace :db do
  desc 'Populate database'
  task populate: :environment do
    admin = Admin.create!( password:               'adminadmin',
                           password_confirmation:  'adminadmin',
                           email:                  'admin@rubymen.com',
                           created_at:             Date.today - rand(1..20).days)

    customer = Customer.create!( password:           'adminadmin',
                             password_confirmation:  'adminadmin',
                             email:                  'customer@rubymen.com',
                             created_at:             Date.today - rand(1..20).days)
  end
end
