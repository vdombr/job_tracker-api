# get :posts, to: 'posts#index'

Rivulet.routes.draw do
  post '/user', to: 'users#create'
end
