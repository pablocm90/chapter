class User < ApplicationRecord
  belongs_to :registrations
  validates :picture, :description, :f_name, :l_name, presence: true
end
