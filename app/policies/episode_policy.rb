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
    @user.transactions.where(episode_id: @record.id).any?
  end

end
