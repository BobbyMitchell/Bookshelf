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
    redirect_to book_path(@book)
  end

  # def create
  #   @spaceship = Spaceship.find(params[:spaceship_id])
  #   @booking = Booking.new(booking_params)
  #   @booking.spaceship_id = @spaceship.id
  #   @booking.user = current_user
  #   @booking.total_price = ((@booking.end_date - @booking.start_date).to_i * @spaceship.price)
  #   if @booking.save
  #     render :show
  #   else
  #     redirect_to spaceship_path(@spaceship)
  #   end
  # end
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
