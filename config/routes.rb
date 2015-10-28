Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  namespace :api, defaults: { format: 'json', except: [:new, :edit] } do
    namespace :v1 do

      resources :users do
        collection do
          post :signin
          post :retrieve_password, :path => '/retrieve-password'
          get :me
          get :exists, :path => '/exists/:name'
        end
        member do
          get :activate
        end
      end
      resources :organizations do
        resources :memberships do
          collection do
            get :pending
            post :integration, :path => '/:id/integration'
          end
          member do
            get :activate
          end
        end
      end
      resources :applications
      resources :services
      resources :service_types, :path => '/service-types'
      resources :accounts
    end
  end

  # match 'api/v1/authorize' => 'api/v1/authorization#authorize', via: [:get,:post]
  # Add a catch-all route
  match "*any" => lambda { |r| [ 404, {}, []] }, via: [:all]
end
