Rails.application.routes.draw do
  devise_for :users
  resources :wallpapers
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
    root 'wallpapers#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
      post 'wallpaper/vote' =>'wallpapers#vote'
      get 'user/:username' => 'user#show'
      get 'user/:username/submitted' => 'user#submitted'
      post 'wallpaper/temp-pic'=>'wallpapers#temp_pic'
      get 'wallpaper/show-tags'=>'wallpapers#show_tags'
      get 'wallpaper/add-tags'=>'wallpapers#add_tags'
      get 'home'=>'wallpapers#home'
      get 'buying-guide'=>'wallpapers#guide'
      get '.well-known/acme-challenge/kpB2nJjAtlD7zc6VDsP093JPQUwL4xlgjxI3wsoLWsA'=>'wallpapers#file1'
      get '.well-known/acme-challenge/9j1ELK2VRcbG0FaGzG2V3412xFXjqT8pF23AR8F6sHY'=>'wallpapers#file2'
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
end
