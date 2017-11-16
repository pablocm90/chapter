class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :content, presence: true
  validates :rating, numericality: true, inclusion: { in: [0, 1, 2, 3, 4, 5], allow_nil: false }
end
