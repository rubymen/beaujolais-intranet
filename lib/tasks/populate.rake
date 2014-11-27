namespace :db do
  desc 'Populate database'
  task populate: :environment do
    admin = Admin.create!( password:               'adminadmin',
                           password_confirmation:  'adminadmin',
                           email:                  'admin@rubymen.com',
                           lastname:               'Lastname',
                           firstname:              'Firstname',
                           type:                   'Admin',
                           created_at:             Date.today - rand(1..20).days)

    customer = Customer.create!( password:           'adminadmin',
                             password_confirmation:  'adminadmin',
                             email:                  'customer@rubymen.com',
                             lastname:               'Lastname',
                             firstname:              'Firstname',
                             type:                   'Customer',
                             created_at:             Date.today - rand(1..20).days)
  end
end
