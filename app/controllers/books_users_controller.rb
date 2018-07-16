class BooksUsersController < ApplicationController



  def new

   @books_user = BooksUser.new(books_user_params)

  end

  def create

  # @books_user.book_id = @book.book_id
  #  @books_user.user = current_user
  #  @books_user.have_book = 1
  #  @books_user.save
  #  redirect_to books_path
   end

  def remove_from_my_bookshelf
    current_user.books.delete(@book)
    redirect_to book_path
  end

  private

    def books_user_params
    params.require(:books_user).permit(:@book, :user)
  end
  def find_book
    @book = Book.find(params[:id])
  end
end
