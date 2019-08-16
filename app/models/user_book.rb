class UserBook < ApplicationRecord
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"
  DEFAULT_IMAGE = "http://spiritualmilk.com/wp-content/uploads/2017/03/genericBookCover.jpg"
  include ActionView::Helpers::SanitizeHelper
  belongs_to :user
  # also belongs to book but Google Books ...

  def fetch_book_info
    url = "#{BASE_URL}/#{book_id}"
    resp = RestClient::Request.execute(url: url, method: "GET")
    resp_obj = JSON.parse(resp)

    {
      id: book_id,
      title: resp_obj["volumeInfo"]["title"],
      author: resp_obj["volumeInfo"]["authors"][0],
      image: resp_obj["volumeInfo"]["imageLinks"] ? resp_obj["volumeInfo"]["imageLinks"]["thumbnail"] : DEFAULT_IMAGE
    }
  end

  def fetch_detailed_book_info
    url = "#{BASE_URL}/#{book_id}"
    resp = RestClient::Request.execute(url: url, method: "GET")
    resp_obj = JSON.parse(resp)

    {
      id: book_id,
      title: resp_obj["volumeInfo"]["title"],
      author: resp_obj["volumeInfo"]["authors"][0],
      image: resp_obj["volumeInfo"]["imageLinks"] && resp_obj["volumeInfo"]["imageLinks"]["medium"] ? resp_obj["volumeInfo"]["imageLinks"]["medium"] : DEFAULT_IMAGE,
      description: resp_obj["volumeInfo"]["description"] ?
        strip_tags(resp_obj["volumeInfo"]["description"]) :
        "No description available"
    }
  end
end
