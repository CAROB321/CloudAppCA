require 'test_helper'

class GenreTest < ActiveSupport::TestCase
  # Use Case 1: Creating a new genre
  test "should create a new genre if it does not already exist" do
    genre_name = "DIY"
    existing_genre = Genre.find_by(name: genre_name)
    assert_nil existing_genre, "Genre already exists in the database"

    genre = Genre.new(name: genre_name)
    assert genre.save, "Failed to create a new genre with the specified name"

    assert_not_nil Genre.find_by(name: genre_name), "Genre was not found in the database after creation"
  end

  # Use Case 2: Preventing the creation of a duplicate genre
  test "should not create a genre if it already exists and should warn the user" do
    
    duplicate_genre = Genre.new(name: @existing_genre_name)
    assert_not duplicate_genre.save, "Saved a duplicate genre, which should not happen"

    assert_includes duplicate_genre.errors[:name], "has already been taken", "Expected error message not found"
  end

  # Use Case 3: Deleting a genre with no associated books
  test "should delete genre if it does not contain books and prompt user" do
    
    genre = Genre.create!(name: "Science Fiction")
    assert genre.persisted?, "Failed to create the genre"

    assert_difference 'Genre.count', -1 do
      genre.destroy
    end

    assert_nil Genre.find_by(name: "Science Fiction"), "Genre was not deleted from the database"
  end

  #didn't get to implement no deletion of parent that has child objects so left out for now
  # Use Case 4: Preventing the deletion of a genre with associated books
    # genre = Genre.create!(name: "Historical Fiction")
    #assert genre.persisted?, "Failed to create the genre"
    
    #genre.books.create!(title: "The Book Thief", author: "Markus Zusak")
    
    #assert_raises(ActiveRecord::DeleteRestrictionError) do
     # genre.destroy!
    #end
    
    #assert_not_nil Genre.find_by(name: "Historical Fiction"), "Genre was deleted even though it has associated books"
  #end

  # Use Case 5: Editing a genre name
  test "should update genre name if the new name is not already in use" do
    new_name = "Childrens"
    @existing_genre.update!(name: new_name)

    @existing_genre.reload
    assert_equal new_name, @existing_genre.name, "Failed to update the genre name to a new unique name"
  end

  # Use Case 6: Preventing update if the new genre name is already in use
  test "should not update genre name if the new name is already in use and inform the user" do
    
    genre2 = Genre.create!(name: "Cookery")
    
    @existing_genre.name = genre2.name
    assert_not @existing_genre.save, "Saved the genre with a name that is already in use"

    assert_includes @existing_genre.errors[:name], "has already been taken", "Expected error message not found"

    @existing_genre.reload
    assert_equal "Fantasy", @existing_genre.name, "Genre name was incorrectly updated"
  end

  # Use Case 7: Editing a genre's location
  test "should update genre location if the new location is not occupied by another genre" do
    
    genre1 = Genre.create!(name: "Action", location: "Shelf 1")
    genre2 = Genre.create!(name: "Adventure", location: "Shelf 2")

    assert genre1.persisted?, "Failed to create the first genre"
    assert genre2.persisted?, "Failed to create the second genre"

    new_location = "Shelf 3"
    genre1.update!(location: new_location)

    genre1.reload
    assert_equal new_location, genre1.location, "Failed to update the genre location to a new unique location"
  end

  # Use Case 8: Preventing update if the new location is already occupied by another genre
  test "should not update genre location if the new location is already occupied and inform the user" do
   
    genre1 = Genre.create!(name: "Horror", location: "Shelf 1")
    genre2 = Genre.create!(name: "Science Fiction", location: "Shelf 2")

    assert genre1.persisted?, "Failed to create the first genre"
    assert genre2.persisted?, "Failed to create the second genre"

    genre1.location = genre2.location
    assert_not genre1.save, "Saved the genre with a location that is already occupied"

    assert_includes genre1.errors[:location], "has already been taken", "Expected error message not found"

    genre1.reload
    assert_equal "Shelf 1", genre1.location, "Genre location was incorrectly updated"
  end

  # Use Case 9: Preventing creation of a genre when the name field is left empty
  test "should not create a genre if the name is blank and inform the user" do

    genre = Genre.new(name: "")
    
    assert_not genre.save, "Saved the genre with an empty name"

    assert_includes genre.errors[:name], "can't be blank", "Expected error message for blank name not found"
  end
end
