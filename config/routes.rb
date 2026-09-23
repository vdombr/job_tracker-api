# get :posts, to: 'posts#index'

Rivulet.routes.draw do
  get  '/user',  to: 'users#show'
  post '/user',  to: 'users#create'
end
