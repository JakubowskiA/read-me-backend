class User < ApplicationRecord
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"
  DEFAULT_IMAGE = "http://spiritualmilk.com/wp-content/uploads/2017/03/genericBookCover.jpg"
  has_many :user_books

  def search_books(author)
    url = "#{BASE_URL}/?q=inauthor:#{User.parse_author_string(author)}"
    resp = RestClient::Request.execute(url: url, method: "GET")
    resp_obj = JSON.parse(resp)

    if resp_obj["items"]
      resp_obj["items"].map do |item|
        {
          title: item["volumeInfo"]["title"],
          author: item["volumeInfo"]["authors"][0],
          image: item["volumeInfo"]["imageLinks"] ? item["volumeInfo"]["imageLinks"]["thumbnail"] : DEFAULT_IMAGE
        }
      end
    else
      []
    end
  end

  def self.parse_author_string(author)
    author.downcase.gsub(" ", "-")
  end
end
