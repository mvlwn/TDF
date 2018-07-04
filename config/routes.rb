TDF::Application.routes.draw do

  devise_for :players

  resources :stages,
            :only => [:index, :show, :edit, :update] do
    collection do
      get :player_points
    end
    member do
      get :email
    end
    resources :scores do
      collection do
        get :bulk_edit
        patch :bulk_update
      end
    end
  end

  resources :players do
    member do
      get :points
      get :riders
      put :toggle
      get :stage_points
    end
  end

  resources :player_teams,
            :only => [:show, :edit, :update] do
    member do
      get :pick_substitute, action: 'pick_substitute'
      post :substitute, action: 'add_substitute'
      delete :substitute, :action => 'remove_substitute'
      post :rider, :action => 'add_rider'
      delete :rider, :action => 'remove_rider'
    end
  end

  resources :teams
  resources :riders do
    collection do
      get :edit_index
      put :update_index
    end
    member do
      put :toggle
    end
  end

  get '/rules' => 'rules#show', :as => 'rules'

  resources :rankings do
    get :scores, :on => :collection
  end

  resources :subpools do
    post :subscribe, on: :member
  end

  resources :subpool_players do

  end

  resource :summary, :only => 'show', :controller => 'summary' do
    get :signup, on: :collection
    get :not_found, :on => :collection
  end

  resource :account, :only => 'show', :controller => 'account'

  root :to => 'summary#show'

end
