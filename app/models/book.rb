class Book < ApplicationRecord
  has_many :isbns
  has_and_belongs_to_many :syllabi
end
