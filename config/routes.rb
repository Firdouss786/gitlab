Rails.application.routes.draw do

  resources :feature_flags
  resources :maintenance_actions
  resources :api_authorizations
  resources :repair_orders
  resources :removal_reasons
  resources :part_transactions
  resources :defer_reasons

  scope 'aircrafts/:aircraft_id' do
    resources :flights, only: :index, module: 'aircrafts'
  end


  resources :docks, only: [:index]

  resources :intent_handlers, only: [:create]

  resources :activities do
    get :open, on: :member
    resources :sign_offs, only: [:show, :new, :create]
    resources :tasks
    resources :task_actions
    resources :faults do
      resources :corrective_actions do
        collection do
          get :consumable_products, :consumable_batches, :consumable_install_quantity
          get :rotable_part_off, :rotable_part_on, :rotable_serial_on
        end
      end
      resources :deferral_actions, except: [:index] do
        get :parts_required, on: :collection
      end
      get :discrepancy_names, on: :collection
      get :clone, on: :member
    end
    resource :fault_resolutions, only: [:edit, :update]

  end

  resources :discrepancy_categories do
    resources :discrepancies, except: [:destroy]
  end

  # resources :faults do
  #   get :discrepancy_names, on: :collection
  # end

  # resources :activities
  # resources :faults
  resources :notifications, only: [:index]
  resources :approvals, only: [:update, :destroy]

  resources :search, only: [:index, :create]


  # ----------------------
  # Airlines, Configs and Aircraft
  # ----------------------

  resources :airlines do
    resources :deferrals, only: [:index, :show], module: :airlines
    resources :corrective_actions, only: [:show], module: :airlines

    resources :flights, only: [:index]
    resources :tasks, shallow: true do
      resources :task_actions
    end

    resources :flight_subscriptions, only: [:index, :create, :destroy] do
      get 'subscribe_all_aircrafts', on: :collection
    end
    resources :programs, shallow: true, only: [:edit, :update]
    resources :task_templates
    resources :campaigns, only: [:show]

    resources :fleets
  end

  scope 'fleets/:fleet_id' do
    resources :product_allotments
    resources :aircrafts
    resources :seats, only: [:index, :new, :create]
    resources :bom_uploads, only: [:new, :create]
  end
  # post 'upload_bom', to: 'fleets#upload_bom'

  resources :comments, only: [:edit, :update, :destroy]

  # put 'approve_issue/:id', to: 'issues#approve', as: 'approve_issue'

  # resources :campaigns, only: [:show]

  # ----------------------
  # Sessions
  # ----------------------


  resources :stations do
    resources :users, only: [:index], module: 'stations'
    resources :activities, shallow: true

    resources :deferrals, only: [:index, :show], module: :stations
    resources :corrective_actions, only: [:show], module: :stations
    resources :campaigns, only: [:index, :show], module: :stations

    scope module: :stations do
      resources :user_routings, only: [:new, :create]
    end

    resources :stock_locations do
      scope module: :stock_locations do
        resources :states, only: [:index, :show]
      end
    end
  end
  get "stations/:id/archived_users", to: 'stations/users#archived', as: 'archived_station_users'

  resources :access_denials, only: :show

  resources :users, only: [:edit, :create, :update, :new] do
    # User API Tokens Section
    resources :tokens, only: [:new, :create], module: 'users'

    # User Accesses Section
    get :accesses, to: 'users/accesses#index'
    patch :accesses, to: 'users/accesses#update'

    # User Qualifications Section
    get :qualifications, to: 'users/qualifications#index'
    patch :qualifications, to: 'users/qualifications#update'

    # User Security Section
    get :security, to: 'users/security#index'
    patch :security, to: 'users/security#update'

    # Log Events
    get :events, to: 'users/events#index'
  end

  # resources :approvals, :only => [:edit]

  # ----------------------
  # Users
  # ----------------------
  # resources :users


  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  post   '/verify',    to: 'sessions#verify'
  delete '/logout',   to: 'sessions#destroy'

  # match "users/update_home_station", :to => "users#update_home_station", :via => :get
  # get 'update_home_station', to: 'users#update_home_station'
  # patch :update_home_station
  # put :update_home_station

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :flight_notifications, only: [:create]

  # ----------------------
  # Stock Locations, Stock Items and Transfers
  # ----------------------



  resources :transfers


  # ----------------------------------------





  resources :airports


  resources :products
  resources :product_allotments



  # resources :task_templates do
  #   put :run
  #   put :pause
  #   put :terminate
  # end

  # resources :task_actions_users
  # resources :task_actions
  # resources :tasks

  resources :manufacturers

  resources :software_platforms
  resources :aircraft_types
  resources :product_categories
  resources :level_recommendations
  resources :certificates
  # resources :transfers
  resources :stock_items do
    resources :events, only: :index, module: 'stock_items'
  end
  resources :profiles
  resources :addresses

  resources :my_home, only: [:index]
  root :to => "my_home#index"

  get '/changelog', to: 'changelogs#index'
  get '/apidocs', to: 'apidocs#index'
  get '/apidocs/:id', to: 'apidocs#show'

  require 'sidekiq/web'
  constraints lambda {|request| request.session[:user_id].present? } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
