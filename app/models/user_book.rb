class UserBook < ApplicationRecord
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"
  DEFAULT_IMAGE = "http://spiritualmilk.com/wp-content/uploads/2017/03/genericBookCover.jpg"

  belongs_to :user
  # also belongs to book but Google Books ...

  def fetch_book_info
    url = "#{BASE_URL}/#{book_id}"
    resp = RestClient::Request.execute(url: url, method: "GET")
    resp_obj = JSON.parse(resp)

    {
      title: resp_obj["volumeInfo"]["title"],
      author: resp_obj["volumeInfo"]["authors"][0],
      image: item["volumeInfo"]["imageLinks"] ? item["volumeInfo"]["imageLinks"]["thumbnail"] : DEFAULT_IMAGE
    }
  end
end
