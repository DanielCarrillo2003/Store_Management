Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "pages#home"
  devise_for :users, controllers: { registrations: 'users/registrations' }

  #RUTAS DE PRODUCTOS
  get 'personal/products', to: 'products#index'
  post 'product', to: 'products#create'
  delete 'product/:id', to: 'products#destroy', as: 'delete_product'
  patch 'product/:id', to: 'products#update', as: 'update_product'
  get 'personal/products/new', to: 'products#new'
  get 'personal/products/edit/:id', to: 'products#edit', as: 'edit_product'
  get 'products', to: 'products#products_to_buy', as: 'available_products'
  get 'products/total', to: 'products#total'
  get 'buy/product-details/:id', to: 'products#show_product_details_to_buyer', as: 'see_product_details_for_buyer'

  #RUTAS DE VENTAS
  resources :sales, only: [:index]
  get 'sale/:id', to: "sales#sale_details", as: 'see_sale_details'

  #RUTAS DE CATEGORIAS
  resources :categories

  #RUTAS DE LOTES
  resources :lots, only: [:create]

  #RUTAS DE PROVEEDORES
  resources :suppliers
  get '/:id/products', to: 'suppliers#get_products', as: 'see_supplier_products'
  get 'movements', to: 'suppliers#get_movements', as: 'get_products_movements'

  #RUTAS PAL CARRITO
  resources :cart_items, only: [:create, :update, :destroy] do
    post 'checkout', on: :collection
  end

  #RUTAS DE LAS ROTACIONES
  resources :rotations, only: [:index, :create, :update]
end