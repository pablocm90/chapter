class User < ApplicationRecord

  belongs_to :registration
  has_many :authors
  has_many :transactions
  has_many :reviews
  mount_uploader :picture, CoverPicUploader
  # validates :description, :f_name, :l_name, presence: true
end
