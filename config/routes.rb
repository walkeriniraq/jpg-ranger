JpgRanger::Application.routes.draw do
  root 'home#index'

  get 'globals', to: 'home#globals'

  resources :photos, except: [:new, :edit] do
    member do
      get 'small_thumb'
      get 'medium_thumb'
      get 'full'
      get 'next'
      get 'previous'
    end
  end

end
