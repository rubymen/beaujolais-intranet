BeaugolaisIntranet::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  scope '/manage' do
    resources :users
  end

end
