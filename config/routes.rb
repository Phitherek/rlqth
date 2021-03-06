Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root to: redirect('/address')
  get '/logout', to: "main#logout"
  get '/auth/:provider/callback', to: "main#omniauth_callback", as: :omniauth_callback
  get '/address', to: "main#address"
  post '/address', to: "main#address_locator"
  get '/ip', to: "main#ip"
  post '/ip', to: "main#ip_locator"
  get '/pure', to: "main#pure"
  post '/pure', to: "main#pure_locator"
  get '/reverse', to: "main#reverse"
  post '/reverse', to: "main#reverse_query"
  get '/geolocate', to: "main#geolocate"
  get '/history', to: "main#history"
  get '/get_i18n', to: "main#get_i18n"
  post '/api/address', to: "api#address"
  post '/api/ip', to: "api#ip"
  post '/api/pure', to: "api#pure"
  post '/api/reverse', to: "api#reverse"
end
