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
    @book = Book.new(book_params)
    #if statement so if book does not meet validations it does not lose data
    if @book.save
    redirect_to books_path
  else
    render :new
  end

  end

  def edit

  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :new
    end
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
