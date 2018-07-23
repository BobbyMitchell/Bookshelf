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
    raise
    @book = Book.find(params[:book_id])
    @user = current_user
    @user_book = UserBook.find(params[:id])

  end

  #when book is changed from reading list to bookshelf
  def update
    raise
    @book = Book.find(params[:book_id])
    @user_book = UserBook.find(params[:id])
  end


  #when book is removed from bookcase
  def destroy
    @user_book = UserBook.find(params[:id])
    @user_book.destroy
  end

  private
  #user_id on params?
  def user_book_params
    params.require(:user_book).permit(:book_id, :have_or_want, :_destroy)
  end

  def destroy_multiple
    user_book_array = current_user.user_books.where(user: current_user, book: @book)
    if user_book_array.length == 2

      x = user_book_array.first
      y = user_book_array.last
        if x.have_or_want == false && y.have_or_want == false
           current_user.user_books.destroy_all
      elsif x.have_or_want == false
          x.destroy
        else
        current_user.user_books.destroy_all

        end

    end
  end


end

#simple form code from book#show
#this on creates user_book and works
# <%= simple_form_for [@book, @user_book] do |f| %>
# <%= f.input :have_or_want,
# :collection => [[true, 'Add to Bookshelf'], [false, 'Add to resding list']],
# :label_method => :last,
# :value_method => :first,
# :as => :radio_buttons %>
# <%= f.submit "Submit" %>
# <% end %>

# #this is turn an have_or_want from true to false but cannot access the edit method
# <%= simple_form_for [@book, @user_book], url: book_user_book_path(@book, @user_book), method: :patch  do |f| %>
# <%= f.input :have_or_want %>
# <%= f.submit "Submit" %>
# <% end %>
