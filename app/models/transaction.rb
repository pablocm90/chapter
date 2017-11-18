class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :episode, optional: true
  belongs_to :book
  belongs_to :author

  validates :episode, uniqueness: {socpe: :user}

end
