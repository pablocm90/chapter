class Episode < ApplicationRecord
  belongs_to :book
  has_many :transactions
  validates :title, presence: true
  validates :content, length: { minimum: 20 }
  validates :description, presence: true
  validates :number, uniqueness: {scope: :book}
  validates :book, presence: true
  validates :price, presence: true

end
