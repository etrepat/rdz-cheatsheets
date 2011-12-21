# Una ruta, conecta una adreça URL a una acció en un controlador.
#
# Es configuren en `config/routes.rb`

#### Rutes bàsiques

YourApp::Application.routes.draw do
  resources :posts
  match '/all' => 'posts#index'
  root :to => "home#index"
end

#### Rutes anidades

namespace :api do
  namespace :internal do
    resources :accounts do
      resources :orders
      member do
        get   :summary
        post  :suspend
      end
      post :confirm, :on => :member
      collection do
        get :pending
      end
      get :blocked, :on => :collection
    end
  end
end

#### Paràmetres opcionals

match '/posts(/:yy(:mm))' => 'posts#index'

class PostsController < ApplicationController
  def index
    params[:yy]
    params[:mm]
  end
end

#### Redirecció

match '/sign_out'     => redirect('/signout')
match '/users/:name'  => redirect { |params| "/#{params[:name]}" }
match '/google'       => redirect('http://www.google.com')

#### Rutes amb nom (Named routes)

# Ens dona accés als helpers `sign_in_path` i `sign_in_url`
match '/sign_in' => 'session#new', :as => 'sign_in'
# Ens genera els helpers `reset_password_path(:token)` i
# `reset_password_url(:token)`
match '/reset_password/:token' => 'users#reset_password',
  :as => 'reset_password'

#### Rutes Rack (Rack Routing)
# Podem enllaçar punts d'entrada arbitràris del nostre esquema de rutes
# amb codi Rack o altres aplicacions (compatibles amb Rack)

get '/hello'          => proc { |env| [200, {}, "Hola Rack!"] }
get '/rack_endpoint'  => PostsController.action(:index)
get '/rack_app'       => CustomRackApp

#### Restriccions (Constraints)

match '/:year' => 'posts#index', :constraints => {:year => /\d{4}/}

constraints(:host => /localhost/) do
  resources :posts
end

# `IpRestrictor` ha d'implementar el mètode `self.matches?(request)`
constrains IpRestrictor do
  get 'admin/accounts' => 'secret#accounts'
end

#### Ruta "Legacy"

# Comentada per defecte. És una ruta *catch all*.
match '/:controller(/:action(/:id(.:format)))'

#### Àmbit (scope)

# Requereix del paràmetre token per a obtenir els recursos que defineix i ha
# de tenir 5 caràcters alfanumèrics
scope ':token', :token => /\w{5}/ do
  resources :rooms do
    resources :meetings
  end
end

# En aquestes rutes `:locale` és opcional
scope '(:locale)', :locale => /en|es/ do
  resources :posts
  root :to => 'posts#index'
end
