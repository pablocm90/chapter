class User < ApplicationRecord
  mount_uploader :photo, CoverPicUploader
  belongs_to :registration
  has_many :transactions
  validates :picture, :description, :f_name, :l_name, presence: true
end
