Rails.application.routes.draw do
  #9 July 2017
  # root changed by Michelle so it directs straight to map
  root to: 'posts#map'

  # new julian code
  get '/login' => 'session#new'         #login form
  post '/login' => 'session#create'   # check credentials and attempt login
  delete '/login' => 'session#destroy'  # log out destroy session


  # route map erb to map controller - Andy
  get '/posts/map' => 'posts#map'

  post '/posts/search' => 'posts#do_search'
  # post '/posts/search' => 'posts#do_search'

  resources :comments
  resources :users

  # 9 July 2017
  # By: Michelle
  # post route amended to allow for upvotes
  resources :posts do

    member do
      post 'upvote'
      post 'downvote'
    end


  end

end
