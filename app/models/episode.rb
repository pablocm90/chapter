class Episode < ApplicationRecord
  belongs_to :book
  belongs_to :transactions, optional: true
  has_many :transactions
  validates :title, presence: true
  validates :content, length: { minimum: 20 }
  validates :description, presence: true
  validates :number, uniqueness: {scope: :book}
  validates :book, presence: true
  validates :price, presence: true
  after_create :author_owns_episode

  def to_s
    title
    title.split.first
  end

  private
  def author_owns_episode
    Transaction.create(user: self.book.author.user, book: self.book, episode: self)
  end

end
