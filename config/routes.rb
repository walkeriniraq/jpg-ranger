JpgRanger::Application.routes.draw do
  root 'home#index'

  post 'upload', to: 'home#upload'
  post 'tag_photo', to: 'home#tag'
  get 'preview/:id', to: 'home#preview', as: 'preview'
  post 'delete/:id', to: 'home#delete', as: 'delete'

  get 'photo/:id', to: 'home#photo', as: 'photo'
  get 'small_thumb/:id', to: 'home#small_thumb', as: 'small_thumb'
  get 'medium_thumb/:id', to: 'home#medium_thumb', as: 'medium_thumb'

  get 'collection/tag/:tag', to: 'collection#tag', as: 'tag_collection'
end
