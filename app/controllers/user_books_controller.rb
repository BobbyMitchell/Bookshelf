class UserBooksController < ApplicationController


  #to show either bookshelf or reading list. one my use another method
  # def index
  #   @my_books = current_user.user_books.where(have_or_want: true)
  # end

  # def my_reading_list
  #   @my_books = current_user.user_books.where(have_or_want: false)
  # end

  #not needed
  def show

  end
  #created by the books_controller
  def new
    @user = current_user

    @user_book = UserBook.new(user_book_params)
  end

  #created by the books_controller
  def create
    @book = Book.find(params[:book_id])
    @user_book = UserBook.new(user_book_params)
    @user_book.book_id = @book.id
    @user_book.user = current_user
    @user_book.save
    destroy_multiple
    redirect_to book_path(@book)
  end

  def edit
     @user_book = UserBook.find(params[:id])
     raise
  end

  #when book is changed from reading list to bookshelf
  def update
    @user_book = UserBook.find(params[:id])
  end


  #when book is removed from bookcase
  def destroy
    @user_book = UserBook.find(params[:id])
    @user_book.destroy
  end

  private

  def user_book_params
    params.require(:user_book).permit(:book_id, :have_or_want)
  end

  def destroy_multiple
    user_book_array = current_user.user_books.where(user: current_user, book: @book)
    if user_book_array.length == 2
      x = user_book_array.first
      x.destroy
    else
    end
  end


end
