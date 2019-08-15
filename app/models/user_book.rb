class UserBook < ApplicationRecord
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"
  belongs_to :user
  # also belongs to book but Google Books ...

  def fetch_book_info
    url = "#{BASE_URL}/#{book_id}"
    resp = RestClient::Request.execute(url: url, method: "GET")
    resp_obj = JSON.parse(resp)

    {
      title: resp_obj["volumeInfo"]["title"],
      author: resp_obj["volumeInfo"]["authors"][0],
      image: resp_obj["volumeInfo"]["imageLinks"]["thumbnail"]
    }
  end
end
