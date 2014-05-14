JpgRanger::Application.routes.draw do
  root 'home#index'

  post 'upload', to: 'home#upload'
  post 'tag_photo', to: 'home#tag'
  get 'preview/:filename.:ext', to: 'home#preview', as: 'preview'

  get 'photo/:filename.:ext', to: 'home#photo', as: 'photo'
  get 'small_thumb/:filename.:ext', to: 'home#small_thumb', as: 'small_thumb'
  get 'medium_thumb/:filename.:ext', to: 'home#medium_thumb', as: 'medium_thumb'

  get 'collection/tag/:tag', to: 'collection#tag', as: 'tag_collection'
end
