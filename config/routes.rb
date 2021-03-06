Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/', to: 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'
  delete '/pets/:pet_id', to: 'pets#destroy'

  get '/shelters/:shelter_id/pets', to: 'pets#index_shelter'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/users', to: 'users#index'
  get '/users/new', to: 'users#new'
  get '/users/:user_id', to: 'users#show'
  post '/users/:user_id', to: 'users#create'

  get '/shelters/:shelter_id/reviews', to: 'reviews#index'
  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'reviews#create'
  get '/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/reviews/:review_id', to: 'reviews#update'
  delete '/reviews/:review_id', to: 'reviews#destroy'

  get '/applications/new', to: 'applications#new'
  post '/applications/', to: 'applications#create'
  get '/applications/:application_id', to: 'applications#show'
  get '/applications/:application_id/edit', to: 'applications#edit'
  patch '/applications/:application_id', to: 'applications#update'

  get '/admin/applications/:application_id', to: 'admin_applications#show'
  patch '/admin/applications/:application_id', to: 'admin_applications#update'
end
