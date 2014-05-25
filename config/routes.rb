JpgRanger::Application.routes.draw do
  root 'home#index'

  resources :photos, except: [:new, :edit] do
    member do
      get 'small_thumb'
      get 'medium_thumb'
      get 'full'
    end
  end

end
