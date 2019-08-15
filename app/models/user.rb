BASE_URL = "https://www.googleapis.com/books/v1/volumes"

class User < ApplicationRecord
  has_many :user_books

  # def search_books(author)
  #   url = "#{BASE_URL}/q=inauthor:#{User.parse_author_string(author)}"
  #   resp = RestClient::Request.execute(url: url, method: "GET")
  #   puts resp["items"][0]["volumeInfo"]
  # end NEED TO TEST

  def self.parse_author_string(author)
    author.downcase.gsub(" ", "-")
  end
end
