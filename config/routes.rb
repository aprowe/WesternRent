Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

  # Example of regular route:
  post 'login' => 'application#login'
  get 'login' => 'application#login'
  get 'logout' => 'application#logout'

  get 'messageUser' => 'application#messageUser'

  get 'post' => 'application#post'

  get 'changePassword' => 'application#changePassword'
  
  get 'postUtilities' => 'application#postUtilities'

  get 'getComments' => 'application#getComments'

  get 'createExpense' => 'application#createExpense'
  get 'deleteExpense' => 'application#deleteExpense'

  get 'resetRent' => 'application#resetRent'
  get 'calcRent' => 'application#calcRent'
  get 'adminLogin' => 'application#adminLogin'
  get 'userPaid' => 'application#userPaid'
  get 'sendTexts' => 'application#sendTexts'
  get 'profile' => 'application#profile'
  post 'upload' => 'application#upload'
  get 'updatePhone' => 'application#updatePhone'
  
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
