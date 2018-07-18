class UserBooksController < ApplicationController


  #to show either bookshelf or reading list. one my use another method
  def index
    @my_books = current_user.user_books.where(have_or_want: true)
  end

  #not needed
  def show

  end
  #created by the books_controller
  def new

  end

  #created by the books_controller
  def create

  end

  #to find book which is to be updated
  def edit

  end

  #when book is changed from reading list to bookshelf
  def update

  end


  #when book is removed from bookcase
  def destroy

  end

  private

  def user_book_params
    params.require(:user_book).permit(:book_id, :have_or_want)
  end



end
