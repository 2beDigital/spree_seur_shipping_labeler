Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
        resources :seur_labels
        member do
          post :show_shipment_state, to: 'orders#show_shipment_state'
        end
    end
    resources :shipping_methods do
        collection do
          post :show_tracking_shippings, to: 'shipping_methods#show_tracking_shippings'
        end
        member do
          post :show, to: 'shipping_methods#show'
        end
    end
  end

  resources :orders do
    member do
      post :show_shipment_state, to: 'orders#show_shipment_state'
    end
  end

  namespace :api do
    resources :orders do
      resources :shipments do
  	    member do
  	      post :generate_seur_label, to: 'shipping_labels#generate_seur_label'
  	    end
      end
    end
  end
end