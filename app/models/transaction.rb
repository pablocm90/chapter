class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :episode, optional: true
  belongs_to :book

  validates :episode, uniqueness: {socpe: :user}

end
