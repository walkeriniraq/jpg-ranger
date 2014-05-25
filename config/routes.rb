JpgRanger::Application.routes.draw do
  root 'home#index'

  post 'upload', to: 'home#upload'
  post 'tag_photo', to: 'home#tag'
  post 'tag_photo_person', to: 'home#tag_person'
  post 'tag_photo_place', to: 'home#tag_place'
  get 'preview/:id', to: 'home#preview', as: 'preview'
  post 'delete/:id', to: 'home#delete', as: 'delete'

  get 'photo/:id', to: 'home#photo', as: 'photo'
  get 'small_thumb/:id', to: 'home#small_thumb', as: 'small_thumb'
  get 'medium_thumb/:id', to: 'home#medium_thumb', as: 'medium_thumb'

  get 'collection/tag/:tag', to: 'collection#tag', as: 'tag_collection'
  get 'collection/person/:person', to: 'collection#person', as: 'person_collection'
  get 'collection/place/:place', to: 'collection#place', as: 'place_collection'

  resources :photos, except: [:new, :edit]

end
