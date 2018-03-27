class BooksController < ApplicationController
	before_action :require_login

	def new
		@book = Book.new
	end

	def index
    	@books = Book.all
  	end

	def show
		@book = Book.find(params[:id])
	end

	def create
		@book = Book.new(book_params)
		if @book.save
			flash[:success] = "Book successfully posted!"
			redirect_to @book
		else
			render 'new'
		end
	end




	private

	def require_login
		unless logged_in?
			flash[:error] = "You must be logged in to access this section"
      		redirect_to "/login"
      	end
    end

    def book_params
      params.require(:book).permit(:title, :year, :isbn, :author, :price, :course_number, :image)
    end
end
