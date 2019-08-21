Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/retrieve_user", to: "auth#retrieve"
  post "/signup", to: "users#create"
  post "/login", to: "auth#create"

  get "/user_books/:user_id/:book_id", to: "user_books#show"
  get "/user_books/detail/:user_id/:book_id", to: "user_books#show_detail"
  post "/user_books", to: "user_books#create"
  delete "/user_books/:user_id/:book_id", to: "user_books#destroy"

  get "/users/:user_id/search", to: "users#search"

  get "/users/:user_id/book_detail/:book_id", to: "users#get_detailed_book"
  get "/users/:user_id/my_books", to: "users#show_books"

  # get "/users/:user_id/search/:author_search_string", to: "users#search"
end
