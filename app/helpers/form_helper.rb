module FormHelper
  def setup_book(book)
    @book.user_books ||= UserBook.new
    @book
  end
end
