Rails.application.routes.draw do

  devise_for :employees, :controllers => {
    registrations: "employees/registrations",
    confirmations: "employees/confirmations",
    sessions: "employees/sessions",
    passwords: "employees/passwords"
  }

  resources :admin_dashboard, only: [:index, :destroy, :show] do
    member do 
      post :confirm_employee
    end  
  end

  resources :employees do
    resources :salary_slip do
      member do
        get :show_slip
      end
    end
    resources :bank_detail, except: [:destroy]
  end

  resources :organizations, only: [:edit, :update, :show]

  resources :employees_dashboard, only: [:index, :show]

  devise_scope :employee do
    root to: "employees/sessions#new"
  end

  resources :conversation, only: [:index, :show, :destroy] do
    member do
      post :reply, :restore, :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end

  resources :messages, only: [:new, :create]


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
