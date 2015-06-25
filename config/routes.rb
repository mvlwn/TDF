TDF::Application.routes.draw do

  resources :stages,
            :path => "etappes",
            :only => [:index, :show, :edit, :update],
            :path_names => {
              :index => 'overzicht',
              :show => 'bekijk',
              :edit => 'wijzig',
              :player_points => 'punten'
            } do
    collection do
      get :player_points
    end
    resources :scores,
              path_names: {
                index: 'overzicht',
                new: 'nieuw',
                show: 'bekijk',
                edit: 'wijzig',
                destroy: 'wis'
              }
  end

  resources :players,
            :path => "deelnemers",
            :path_names => {
              :index => 'overzicht',
              :edit => 'wijzig',
              :create => 'maak',
              :points => 'punten',
              :riders => 'renners'
            } do
    member do
      get :points
      get :riders
      put :toggle
    end
  end

  resources :player_teams,
            :only => [:show, :edit, :update],
            :path => 'teams_van_deelnemers',
            :path_names => {
              :edit => 'wijzig'
            } do
    member do
      post :rider, :action => "add_rider"
      delete :rider, :action => "remove_rider"
    end
  end

  resources :teams
  resources :riders, :path => "wielrenners" do
    collection do
      get :edit_index
      put :update_index
    end
    member do
      put :toggle
    end
  end

  match "/rules" => "rules#show", :as => "rules", :path => 'spelregels'

  resources :rankings, :path => 'uitslagen' do
    get :scores, :on => :collection, :path => "scores"
  end

  resources :subpools, :path => 'subpoeles' do

  end

  resources :subpool_players, :path => 'subpoele_spelers'

  resource :summary, :only => "show", :controller => "summary", :path => 'overzicht' do
    get :not_found, :on => :collection, :path => "niets-gevonden"
  end

  resource :account, :only => "show", :controller => "account", :path => 'mijnpoele'
  devise_for :players,
             :path => "mijnpoele",
             :path_names => {
               :sign_in => 'inloggen',
               :sign_out => 'uitloggen',
               :password => 'wachtwoord',
               :confirmation => 'bevestigen',
               :unlock => 'unblock',
               :registration => 'registreren',
               :sign_up => 'aanmelden'
             }

  root :to => 'summary#show'

end
