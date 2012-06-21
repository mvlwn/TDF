TDF::Application.routes.draw do

  devise_for :players

  resources :stages, :only => [:index, :show, :edit, :update]
  resources :players do
    member do
      get :pick
      post :pick, :action => "search_and_pick"
      get :points
      get :riders
      delete :rider, :action => "deselect_rider"
      put :rider, :action => "select_rider"
    end
  end
  resources :riders do
    member do
      put :toggle
    end
  end
  resources :score

  resource :summary, :only => "show", :controller => "summary"
  resource :account, :only => "show", :controller => "account"

  root :to => 'summary#show'

end
