Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    get "/about", to: "homes#about"
    get "/users/my_page", to: "users#show", as: "my_page"
    get "/users/:id/post_list", to: "users#post_list", as: "users_post_list"
    resource :users, only: [:edit, :update]
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
    get "/search", to: "searchs#search"
    get "/search/detail", to: "searchs#detail"
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  namespace :admin do
    root to: "homes#top"
    resources :users, except: [:new, :create, :destroy]
    resources :posts, only: [:show, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
