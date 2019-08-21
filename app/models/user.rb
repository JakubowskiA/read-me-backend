class User < ApplicationRecord
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"
  DEFAULT_IMAGE = "http://spiritualmilk.com/wp-content/uploads/2017/03/genericBookCover.jpg"
  has_many :user_books
  has_secure_password
  include ActionView::Helpers::SanitizeHelper

  validates :email, uniqueness: true

  # def search_books(author)
  #   url = "#{BASE_URL}/?q=inauthor:#{User.parse_author_string(author)}"
  #   resp = RestClient::Request.execute(url: url, method: "GET")
  #   resp_obj = JSON.parse(resp)
  #   if resp_obj["items"]
  #     resp_obj["items"].map do |item|
  #       if item["volumeInfo"]
  #         {
  #           id: item["id"],
  #           title: item["volumeInfo"]["title"],
  #           author: item["volumeInfo"]["authors"] ? item["volumeInfo"]["authors"][0] : "C'mon google",
  #           image: item["volumeInfo"]["imageLinks"] ? item["volumeInfo"]["imageLinks"]["thumbnail"] : DEFAULT_IMAGE
  #         }
  #       else
  #         {}
  #       end
  #     end.select do |book|
  #       !self.user_books.map(&:book_id).include?(book[:id])
  #     end
  #   else
  #     []
  #   end
  # end

  def search_books(author, title)
    url = nil
    if author != "" && title != ""
      url = "#{BASE_URL}/?q=inauthor:#{User.parse_author_string(author)}+intitle:#{User.parse_author_string(title)}&maxResults=20"
    elsif author == "" && title != ""
      url = "#{BASE_URL}/?q=intitle:#{User.parse_author_string(title)}&maxResults=20"
    elsif author != "" && title == ""
      url = "#{BASE_URL}/?q=inauthor:#{User.parse_author_string(author)}&maxResults=20"
    else
      return []
    end

    resp = RestClient::Request.execute(url: url, method: "GET")
    resp_obj = JSON.parse(resp)
    if resp_obj["items"]
      resp_obj["items"].map do |item|
        if item["volumeInfo"]
          {
            id: item["id"],
            title: item["volumeInfo"]["title"],
            author: item["volumeInfo"]["authors"] ? item["volumeInfo"]["authors"][0] : "C'mon google",
            image: item["volumeInfo"]["imageLinks"] ? item["volumeInfo"]["imageLinks"]["thumbnail"] : DEFAULT_IMAGE
          }
        else
          {}
        end
      end.select do |book|
        !self.user_books.map(&:book_id).include?(book[:id])
      end
    else
      []
    end
  end

  def get_detailed_book(book_id)
    url = "#{BASE_URL}/#{book_id}"
    resp = RestClient::Request.execute(url: url, method: "GET")
    resp_obj = JSON.parse(resp)

    {
      id: book_id,
      title: resp_obj["volumeInfo"]["title"],
      author: resp_obj["volumeInfo"]["authors"][0],
      image: resp_obj["volumeInfo"]["imageLinks"] && resp_obj["volumeInfo"]["imageLinks"]["thumbnail"] ? resp_obj["volumeInfo"]["imageLinks"]["thumbnail"] : DEFAULT_IMAGE,
      description: resp_obj["volumeInfo"]["description"] ?
        strip_tags(resp_obj["volumeInfo"]["description"]) :
        "No description available"
    }
  end

  def self.parse_author_string(author)
    author.downcase.gsub(" ", "-")
  end
end
