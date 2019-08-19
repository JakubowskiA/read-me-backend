Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/user_books/:user_id/:book_id", to: "user_books#show"
  get "/user_books/detail/:user_id/:book_id", to: "user_books#show_detail"
  get "/users/:user_id/my_books", to: "users#show_books"
  get "/users/:user_id/search/:author_search_string", to: "users#search"

  get "/users/:user_id/book_detail/:book_id", to: "users#get_detailed_book"
  post "/user_books", to: "user_books#create"
  delete "/user_books/:user_id/:book_id", to: "user_books#destroy"
end
