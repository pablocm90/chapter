class Registration < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :users
  has_many :authors, through: :users
  # validates :username, presence: true

  after_create :create_user

  private

  def create_user
    users.create
  end
end
