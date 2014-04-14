JpgRanger::Application.routes.draw do
  root 'home#index'

  post 'home/upload'
  post 'home/tag'

end
