class AddGenreTest < ActiveSupport::TestCase
    test "should save genre" do 
        genre = Gemre.new
        assert genre.save
    end
end