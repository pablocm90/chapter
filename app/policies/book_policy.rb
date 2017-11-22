class BookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    @user.author == @record.author
  end

  def create?
    return true
  end

  def download_owned_book?
   @user.owned_episodes(@record).empty? ? false : true
  end

end
