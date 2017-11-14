class User < ApplicationRecord
  belongs_to :registration

  validates :picture, :description, :f_name, :l_name, presence: true
end
