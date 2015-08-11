Rails.application.routes.draw do

  resources :forum_admins, only:[:create, :destroy, :index, :new]

  resources :banned_users, only:[:create, :destroy, :index, :new]

  resources :closed_posts, only:[:create, :destroy, :index, :new]

  get 'results' => 'search#show'

  root 'static_pages#home'

  get 'about' => 'static_pages#about'

  get 'help' => 'static_pages#help'

  get 'forums' => 'topics#index'

  resources :users do
    get 'questions' => 'users#questions'
  end

  resources :notifications, only:[:index, :destroy]

  resources :moderators, only:[:create, :destroy, :index, :new]

  get 'admin_functions' => 'static_pages#admin_functions'

  resources :closings, only:[:create, :new]

  resources :replies, only:[:create, :delete]

  resources :posts, only:[:destroy, :create]

  resources :fields, only:[ :create, :new, :destroy ,:index]

  #resources :questions_votes, only:[:create, :destroy, :edit, :vote]
  get 'question_vote' => 'questions_votes#vote'
  get 'answer_vote' => 'answer_votes#vote'
  get 'best_answer' =>'answers#best'
  get 'signup' => 'users#new'
  get 'login' => 'session#new'
  post 'login' => 'session#create'
  delete 'logout'=> 'session#destroy'

  resources :answers, only:[:create]

  resources :questions, only:[:new, :destroy, :create, :index]

  resources :topics do
    resources :posts
  end

  resources :fields, path: '' , only:[:show]  do
    resources :questions, only:[:show, :edit, :new]
    get 'questions' => 'fields#questions'
    get 'new-moderator' => 'fields#new_moderator'
  end


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
end
