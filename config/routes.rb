Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  get "export_excel" => "welcome#export_excel"
  post 'upload_file' => 'welcome#upload_file'
  get 'upload_files_show' => "welcome#upload_files_show"
end
