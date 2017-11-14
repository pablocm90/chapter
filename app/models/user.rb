class User < ApplicationRecord

  validates :picture, :description, :f_name, :l_name, presence: true
end
