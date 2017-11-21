class User < ApplicationRecord

  belongs_to :registration
  has_one :author
  has_many :transactions
  has_many :reviews
  has_many :episodes, through: :transactions
  has_many :books, through: :transactions
  mount_uploader :picture, CoverPicUploader


  def not_owned_episodes(book)
    book.episodes - episodes
  end

  def owned_episodes(book)
    book.episodes - not_owned_episodes
  end

  def owned_books
    books
  end
  # validates :description, :f_name, :l_name, presence: true
end
