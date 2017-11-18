class Author < ApplicationRecord
  belongs_to :user
  has_many :books
  after_create :user_author

  private

  def user_author
    current_user.is_author = true
    current_user.save
  end

end
