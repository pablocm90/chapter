class Episode < ApplicationRecord
  belongs_to :book

  validates :title, presence: true
  validates :content, length: { minimum: 2000 }
  validates :description, presence: true
  validates :number, uniqueness: {scope: :book}
  validates :book, presence: true

end
