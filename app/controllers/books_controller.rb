class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_book, only: [:show, :edit, :update, :destroy]


  def my_books
    @my_books = Book.where(user: current_user )
  end

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
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
    params.require(:book).permit(:title, :author, :rating, :have_read, :genre, :user_id)
  end
  def find_book
    @book = Book.find(params[:id])
  end

end
