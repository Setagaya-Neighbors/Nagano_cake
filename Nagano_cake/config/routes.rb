Rails.application.routes.draw do
  devise_for :admins
# devise
    devise_for :customers, controllers: {
      registrations: 'public/registrations',
      sessions:      'public/sessions',
    }
# /devise

  # adminのrouting
  namespace :admin do

    # HomesController関連
    root to: "homes#top"
    # /HomesController関連

    # ItemsController関連
    resources :items, except: [:destroy]
    # /ItemsController関連

    # GenresController関連
    resources :genres, except: [:new, :show, :destroy]
    # /GenresController関連

    # CustomersController関連
    resources :customers, except: [:new, :create, :destroy]
    # /CustomersController関連

    # OrdersContoller関連
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
    # /OrdersContoller関連

  end
  #/adminのrouting

  # publicのrouting
  namespace :public do

    # HomesController関連
    root "homes#top"
    get  "/about" => "homes#about"
    # /HomesController関連

    # ItemsController関連
    resources :items,     only: [:index, :show]
    # /ItemsController関連

    # CartItemsController関連
    resources :cart_items, except: [:new, :edit, :show]
    delete "/cart_items/destroy_all" => "cart_items#destroy_all", as:"destroy_all_cart_items"
    # /CartItemsController関連

    # CustomersController関連
    resource :customers, only: [:show, :edit, :update]
    get   "customers/cancel"   => "customers#cancel",   as: "customer_cancel"
    patch "customers/cancel"   => "customers#withdraw", as: "customer_withdraw"
    # /CustomersController関連

    # AddressesController関連
    resources :address, except: [:new, :show]
    # /AddressesController関連

    # OrdersContoller関連
    resources :order, except: [:edit, :update, :destroy, :new]
    get "/orders/cart_item_id/new"      => "orders#new",      as: "new_order"
    get "/orders/cart_item_id/confirm"  => "orders#confirm",  as: "order_confirm"
    get "/orders/complete"              => "orders#complete", as: "order_complete"
    # /OrdersContoller関連


  end
  # /publicのrouting

end

