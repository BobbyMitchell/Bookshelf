<h1><%= @book.title %></h1>
<h1><%= "by #{@book.author}"  %></h1>
<h2><%= @book.genre %></h2>
<h1><%= "*" * @book.rating %></h1>

<!-- if statment with simple forms to edit -change from reading list to bookshelf. and another to destroy. When added to bookcae need to do a rateing and when destroyed need to remove that rating -->

<% if current_user.books.exclude? @book  %>



<!-- this form is for when there is no user_book and adds to either reading list or bookshelf -->
<%= simple_form_for [@book, @user_book] do |f| %>
<%= f.input :have_or_want,
:collection => [[true, 'Add to Bookshelf'], [false, 'Add to resding list']],
:label_method => :last,
:value_method => :first,
:as => :radio_buttons %>
<%= f.submit "Submit" %>
<% end %>

<% elsif @book.user_books[0].have_or_want == false %>

<!-- If is is on the reading list you can add to bookshelf(changes have_or_want to true) or can remove from reading list (delete user_book instance) -->

<%= simple_form_for [@book, @user_book], url: book_user_books_path(@book, @user_book), method: :pu  do |f| %>
<%= f.input :have_or_want, :as => :hidden, :label => 'Remove this book from bookshelf', :input_html => { :value => true } %>
<%= f.submit "Move to Bookcase" %>
<% end %>

<%= simple_form_for [@book, @user_book], url: book_user_books_path(@book, @user_book), method: :pu  do |f| %>
<%= f.input :have_or_want, :as => :hidden, :label => 'Remove this book from bookshelf', :input_html => { :value => false } %>
<%= f.submit "Remove from Reading list" %>
<% end %>


<% else %>
<!-- It is on the bookshelf so option to remove - user_books#destroy?  -->

<%= simple_form_for [@book, @user_book], url: book_user_books_path(@book, @user_book), method: :pu  do |f| %>
<%= f.input :have_or_want, :as => :hidden, :label => 'Remove this book from bookshelf', :input_html => { :checked => true } %>
<%= f.submit "Remove Book" %>
<% end %>


<h1>On bookshelf need option to remove from bookshelf</h1>
<% end %>

<h2><% @book.users do |user| %></h2>
<h2><%= user.email %></h2>
<% end %>

<h3><%= @book.have_read ? "You have read this book" : "You have not read this book" %></h3>
<% @book.comments.each do |comment| %></h3>
<h3><%= comment.content %></h3>
<% end %>
<h2><%= link_to "Review this book", new_book_comment_path(@book) %></h2>
<h2><%= link_to "Edit this book", edit_book_path %></h2>
<h2><%= link_to "Back to Library", books_path %></h2>
<h2> <%= link_to "My Bookshelf", my_books_books_path %> </h2>


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
