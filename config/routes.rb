BeaugolaisIntranet::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  scope '/manage' do
    resources :users
  end

end
