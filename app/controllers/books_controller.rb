class BooksController < ApplicationController

  before_action :find_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.create
  end

  def create
    Book.create(book_params)
    redirect_to books_path

  end

  def edit

  end

  def update
    @book.update(book_params)
    redirect_to book_path(@book)
  end

  def destroy

    @book.destroy
    redirect_to books_path

  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :rating, :have_read)
  end
  def find_book
    @book = Book.find(params[:id])
  end

end
