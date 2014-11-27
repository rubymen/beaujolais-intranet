BeaugolaisIntranet::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  scope '/manage' do
    resources :users do
      put :reset, on: :member
      get :reset, on: :member
    end
  end

end
