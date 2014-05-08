JpgRanger::Application.routes.draw do
  root 'home#index'

  post 'home/upload'
  post 'home/tag'
  get 'home/photo/:filename.:ext', to: 'home#photo'
  get 'home/small_thumb/:filename.:ext', to: 'home#small_thumb'
  get 'home/medium_thumb/:filename.:ext', to: 'home#medium_thumb'

  get 'collection/tag/:tag', to: 'collection#tag'
end
