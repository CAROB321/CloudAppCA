class Genre < ApplicationRecord
    has_many :books, :dependent => :destroy
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :location, presence: true, uniqueness: true
    
  end
  