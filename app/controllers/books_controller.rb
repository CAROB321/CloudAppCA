class BooksController < ApplicationController

  # GET /genres/1/books
  def index
    # For URL like /genres/1/books
    # Get the genre with id=1
    @genre = Genre.find(params[:genre_id])
    # Access all books for that genre
    @books = @genre.books
  end
  
  # GET /genres/1/books/2
  def show
    @genre = Genre.find(params[:genre_id])
    # For URL like /genres/1/books/2
    # Find an book in genres 1 that has id=2
    @book = @genre.books.find(params[:id])
      
  end

  
  
  # GET /genres/1/books/new
  def new
  @genre = Genre.find(params[:genre_id])
  # Associate an book object with genre 1
  @book = @genre.books.build
  end
  
  
 def create
  @genre = Genre.find(params[:genre_id])
  # Build a new book associated with the genre
  @book = @genre.books.build(params.require(:book).permit!)
  
  if @book.save
    # Save the book successfully and redirect
    redirect_to genre_book_path(@genre, @book), notice: 'Book was successfully created.'
  else
    # Render the new template with errors
    render :new, status: :unprocessable_entity
  end
end
  
  # GET /genres/1/books/2/edit
  def edit
  @genre = Genre.find(params[:genre_id])
  # For URL like /genres/1/books/2/edit
  # Get book id=2 for genre 1
  @book = @genre.books.find(params[:id])
  end
  
  # PUT /genres/1/books/2
  #def update
   # @genre = Genre.find(params[:genre_id])
    #@book = Book.find(params[:id])
  
    #if @book.update(params.require(:book).permit(:details))
     # # Save the book successfully
      #redirect_to genre_books_path(@genre)
    #else
     # render :action => "edit"
    #end
  #end

  def update
    @genre = Genre.find(params[:genre_id])
    @book = @genre.books.find(params[:id])
  
    if @book.update(book_params)
      redirect_to genre_book_path(@genre, @book), notice: 'Book was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  
  # DELETE /genres/1/books/2
  def destroy
  @genre = Genre.find(params[:genre_id])
  @book = Book.find(params[:id])
  @book.destroy
  respond_to do |format|
  format.html { redirect_to genre_books_path(@genre) }
  format.xml { head :ok }
  end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_genre
    @genre = Genre.find(params[:genre_id])
  end

  def set_book
    @book = @genre.books.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author, :synopsis)
  end
  
  end