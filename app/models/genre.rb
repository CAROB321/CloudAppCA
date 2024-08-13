class Genre < ApplicationRecord
    has_many :books, :dependent => :destroy
    
    #has_many :books, dependent: :restrict_with_error 
    ##I had intended to implement a restriction to prevent deletioon of the parent object
    #if it contains book objects but ran out of time to implment and test so left 
    #the "are you sure?" check in place for noe
    
    validates :name, presence: true, uniqueness: { case_sensitive: false } #unique genre name is required
    validates :location, presence: true, uniqueness: true #unique shelf location for genre has to be selected
end
