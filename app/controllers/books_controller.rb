class BooksController < ApplicationController
	before_action :require_login,  only: [:new, :create]

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
		@book.user = current_user
		if @book.save
			flash[:success] = "Book successfully posted!"
			redirect_to @book
		else
			render 'new'
		end
	end
	
	def edit
		@book = Book.find(params[:id])
	end	


	def search
		if params[:query].blank?
			redirect_to root_path
		else
			@q = "%#{params[:query]}%"
			@books = Book.where("title LIKE ? or author LIKE ? or isbn LIKE ?", @q, @q, @q)
			render 'index'
		end
	end
	
	def listing
	   Book.find_by_title(params[:title])
	   render 'listing'
	end


	def destroy
		@book = Book.find(params[:id])
	        @book.destroy
	        respond_to do |format|
		        format.html { redirect_to request.referrer, notice: 'Book was successfully destroyed.' }
		        format.json { head :no_content }
	      end

	end

	def update
		@book = Book.find(params[:id])
		if @book.update_attributes(book_params)
			flash[:success] = "Book updated"
      			redirect_to @book
      # Handle a successful update.
    		else
      			render 'edit'
    		end
  end


	def set_book
      		@book = Book.find(params[:id])
    	end


	private

	def require_login
		unless logged_in?
			flash[:error] = "You must be logged in to access this section"
      		redirect_to "/login"
      	end
    end

    def book_params
      params.require(:book).permit(:title, :year, :isbn, :author, :price, :course_number, :image, :user_id)
    end

    
end
