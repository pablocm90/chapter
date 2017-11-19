class Registration < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :user
  has_one :author, through: :user
  # validates :username, presence: true

  after_create :create_user

  private

  def create_user
    user = User.new(tokens: 200)
    user.registration = self
    user.save!
  end
end
