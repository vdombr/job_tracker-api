# get :posts, to: 'posts#index'

Rivulet.routes.draw do
  post '/sign_in', to: 'users#sign_in'

  get  '/user',  to: 'users#show'
  post '/user',  to: 'users#create'
end
