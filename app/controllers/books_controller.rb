class BooksController < ApplicationController
	def new
		@book = Book.new
	end

	def index
    	@book = Book.all
  	end

	def show
		@book = Book.find(params[:id])
	end

	def create
		@book = Book.new(book_params)
		if @book.save
			#flash[:success] = "Book successfully posted!"
			redirect_to @book
		else
			render 'new'
		end
	end




	private

    def book_params
      params.require(:book).permit(:title, :year, :isbn)
    end
end
