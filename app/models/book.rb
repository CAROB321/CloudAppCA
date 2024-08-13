class Book < ApplicationRecord
    belongs_to :genre
    validates :title, presence: true, uniqueness: { case_sensitive: false }
    validates :author, presence: true 
end
  
