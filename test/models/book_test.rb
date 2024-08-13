require "test_helper"

class BookTest < ActiveSupport::TestCase
  # Test that a book can be created with valid attributes
  test "should create book with valid attributes" do
    genre = genres(:one)
    book = genre.books.build(title: "Dune", author: "Frank Herbert")
    assert book.save, "Failed to save the book with valid attributes"
  end

  # Test that a book cannot be created without a title
  test "should not create book without title" do
    genre = genres(:one)
    book = genre.books.build(author: "Frank Herbert")
    assert_not book.save, "Saved the book without a title"
  end

  # Test that a book cannot be created without an author
  test "should not create book without author" do
    genre = genres(:one)
    book = genre.books.build(title: "Dune")
    assert_not book.save, "Saved the book without an author"
  end

  # Test that a book can be created without a synopsis
  test "should create book without synopsis" do
    genre = genres(:one)
    book = genre.books.build(title: "Dune", author: "Frank Herbert")
    assert book.save, "Failed to save the book without a synopsis"
  end

  # Test the association with genre
  test "should belong to a genre" do
    book = books(:one)
    assert_respond_to book, :genre
  end
end