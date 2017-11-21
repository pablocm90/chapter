class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

    def new?
      @user
    end

    def create?
      true
    end
end
