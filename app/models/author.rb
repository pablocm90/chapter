class Author < ApplicationRecord
  belongs_to :user
  has_many :books

  private


end
