ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pages', :action => 'home'

  map.resources :timelines do |timelines|
    timelines.resources :places, :name_prefix => 'timeline_'
  end
  map.resources :places
  map.resources :place_types

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resource :session

  map.with_options(:controller => "users") do |user|
    user.update_profile_details_current_user 'account/update_profile_details', :conditions => {:method => :put}, :action => "update_profile_details"
    user.update_privacy_current_user 'account/update_privacy', :conditions => {:method => :put}, :action => "update_profile_details"
    user.edit_current_user 'account', :conditions => {:method => :get}, :action => "edit"
  end
  map.resources :users, :as => "people", :collection => {:verify => :any, :details => :get, :create => :post}
  map.resources :identity_urls
  map.resource :avatar, :name_prefix => 'current_'
  map.resources :avatars, :member => {:crop => :any}

  map.connect 'insertions.rjs', :controller => 'application', :action => 'insertions'

end
