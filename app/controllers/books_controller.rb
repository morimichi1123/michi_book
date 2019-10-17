class BooksController < ApplicationController
  before_action :logged_in_user

  before_action :admin_user, only: %i[ edit update destroy]
  
  
  def list
    @books = Book.paginate(page: params[:page]).search(params[:search])
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end


  def create
    @book = Book.new(book_params)
    if @book.save
        flash[:success] = "Success Add New Book"
        redirect_to @book
    else
        render 'new'
    end
  end

  def edit
        @book = Book.find(params[:id])
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Book deleted"
    redirect_to index_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Book Information Updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

   private

    def book_params
      params.require(:book).permit(:title, :author, :publisher, :genre)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
