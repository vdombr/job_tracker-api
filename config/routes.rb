# get :posts, to: 'posts#index'

Rivulet.routes.draw do
  post '/sign_in', to: 'users#sign_in'

  get  '/user',  to: 'users#show'
  post '/user',  to: 'users#create'

  get   '/job_apps',     to: 'job_apps#index'
  post  '/job_apps',     to: 'job_apps#create'
end
