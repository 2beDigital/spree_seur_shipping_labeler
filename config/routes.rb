Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
        resources :seur_labels
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