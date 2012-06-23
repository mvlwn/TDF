TDF::Application.routes.draw do

  resources :stages, :only => [:index, :show, :edit, :update] do
    collection do
      get :player_points
    end
  end

  resources :players do
    member do
      get :points
      get :riders
    end
  end

  resources :player_teams, :only => [:show, :edit, :update] do
    member do
      post :rider, :action => "add_rider"
      delete :rider, :action => "remove_rider"
    end
  end

  resources :teams
  resources :riders do
    member do
      put :toggle
    end
  end

  match "/rules" => "rules#show", :as => "rules"
  resources :score

  resource :summary, :only => "show", :controller => "summary"

  resource :account, :only => "show", :controller => "account"
  devise_for :players, :path => "account" #, :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }

  root :to => 'summary#show'

end
