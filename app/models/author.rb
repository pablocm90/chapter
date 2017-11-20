class Author < ApplicationRecord
  belongs_to :user
  has_many :books
  has_many :transactions, through: :books

end
