Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/user_books/:user_id/:book_id", to: "user_books#show"
  get "/users/:user_id/my_books", to: "users#show_books"
  get "/users/:user_id/search/:author_search_string", to: "users#search"

  post "/user_books", to: "user_books#create"
end
