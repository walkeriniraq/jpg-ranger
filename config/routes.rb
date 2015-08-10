JpgRanger::Application.routes.draw do
  root 'home#index'

  get 'globals', to: 'home#globals'
  get 'stats', to: 'home#stats'

  resources :photos, except: [:new, :edit] do
    member do
      get 'small_thumb'
      get 'medium_thumb'
      get 'full'
      get 'next'
      get 'previous'
    end
    collection do
      get 'multi_person_add'
      get 'multi_place_add'
      get 'multi_tag_add'
      get 'multi_collection_add'
    end
  end

end
