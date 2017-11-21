class EpisodePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    @record.book.author.user == @user
  end

  def create?
    @record.book.author.user == @user
  end

  def show?
    # should only show if current user has a transaction for that episode
    @user.owns_episode?(@record)
  end

end
