class Book < ApplicationRecord
    belongs_to :genre
    validates :title, presence: true, uniqueness: { case_sensitive: false } #unique title for book has to be entered
    validates :author, presence: true #author name has to be entered
end
  
