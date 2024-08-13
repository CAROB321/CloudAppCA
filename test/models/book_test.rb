require 'test_helper'

class BookTest < ActiveSupport::TestCase
 # Use Case 10: Adding a new book to a genre when the book name does not already exist
  test "should create a new book if the book name does not already exist" do
    unique_book_name = "The Thursday Murder Club"
    book = @genre.books.create!(title: unique_book_name, author: "Richard Osman")
    
    assert book.persisted?, "Failed to create the book"
    assert_equal unique_book_name, book.title, "Book title was not set correctly"
    assert_equal @genre.id, book.genre_id, "Book was not associated with the genre"
  end

  # Use Case 11: Preventing addition of a new book if the book name already exists
  test "should not create a new book if the book name already exists and inform the user" do
    existing_book_name = "Confessions of a Fallrn Angel"
    @genre.books.create!(title: existing_book_name, author: "Ronan O'Brien")
    
    duplicate_book = @genre.books.new(title: existing_book_name, author: "Daniel O'Brien")
    assert_not duplicate_book.save, "Saved the book with a duplicate name"
    assert_includes duplicate_book.errors[:title], "has already been taken", "Expected error message for duplicate name not found"
  end

  # Use Case 12: Preventing creation of a book if the title is blank and informing the user
  test "should not create a book if the title is blank and inform the user" do
    book = @genre.books.new(title: "", author: "James O'Brien")
    assert_not book.save, "Saved the book with a blank title"
    assert_includes book.errors[:title], "can't be blank", "Expected error message for blank title not found"
  end

  # Use Case 13: Preventing creation of a book if the author name is blank and informing the user
  test "should not create a book if the author name is blank and inform the user" do
    book = @genre.books.new(title: "Confessions of a Fallen Angel", author: "")
    assert_not book.save, "Saved the book with a blank author name"
    assert_includes book.errors[:author], "can't be blank", "Expected error message for blank author name not found"
  end

  # Use Case 14: Editing an existing book with a unique name
  test "should update book with a unique name and save it" do
    original_book_name = "Confessions of a Fallen Angel"
    book = @genre.books.create!(title: original_book_name, author: "Ronan O'Brien")
    assert book.persisted?, "Failed to create the book"

    new_unique_book_name = "COAFA"
    book.update(title: new_unique_book_name)
    
    book.reload
    assert_equal new_unique_book_name, book.title, "Book title was not updated correctly"
    assert book.save, "Book was not saved after update"
  end
end
