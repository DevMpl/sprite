Sprite::Engine.routes.draw do
  
	root :to => "item#index"
	
  resources :items

  get 'item/positions' => 'items#positions', as: :item_positions
  put 'item/update_positions' => 'items#update_positions', as: :item_update_positions
  get 'items/tags' => 'items#tags', as: :items_tags
  get '/items/tag/(:tag)' => 'items#tag'
  delete '/items/clear_page_cache/:id' => 'items#clear_page_cache', as: :item_clear_page_cache
  post '/items/change_data' => 'items#change_data', as: :item_change_data

  resources :pages
  resources :item_categories

  get 'item_categories/:id/move_higher' => 'item_categories#move_higher', as: :move_higher_category
  get 'item_categories/:id/move_lower' => 'item_categories#move_lower', as: :move_lower_category
	
end
