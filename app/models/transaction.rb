class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  belongs_to :book
end
